require 'spec_helper'

shared_examples_for "Checkable" do
  let(:model) { described_class } # the class that includes the concern
  subject(:checkable) { model.new id: 1 }

  it "has a list of checked methods" do
    expect(model.check_hooks).to be_an Array
  end

  describe "#check" do
    before do
      model.on_check def checkable.test_checkable_method
        return true
      end
    end

    it "will call checked methods" do
      model.check_hooks.each do |method|
        allow(checkable).to receive(method)
      end

      checkable.check

      model.check_hooks.each do |method|
        expect(checkable).to have_received(method)
      end
    end
  end

  describe "#delay_check" do
    it "will trigger a perform_async on the worker inner class" do
      allow(model::Worker).to receive(:perform_async).with(model, checkable.id)

      checkable.delay_check

      expect(model::Worker).to have_received(:perform_async)
    end
  end

  describe "::Worker#perform" do
    subject(:worker) { model::Worker.new }

    before do
      allow(model).to receive(:find).with(checkable.id).and_return checkable
    end

    it "checks the object it looks up" do
      allow(checkable).to receive(:check)

      worker.perform model.to_s, checkable.id

      expect(checkable).to have_received(:check)
    end
  end
end

class StaticController < ApplicationController
  def index
  end
  
  def check
    render json: {jid: ScheduledWorker.perform_async}
  end
end

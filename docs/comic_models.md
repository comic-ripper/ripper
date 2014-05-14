## Comic Models
Reading progress is stored per user?  
Will there be multiple users?

### Comic
 * has_many Chapters
 * Stores URL, title, and parser, and parser parameters
  * URL
  * Title
  * General progress info
    * First chapter to grab
    * Limit the number of stored chapters

### Chapter
  * belongs_to Comic
  * has_many Pages
  * chapter number
    * Could contain letters, so this will have to be a string.
    * Being a string can make things weird
  * volume number
    * Must be a number
    * is optional
  * Ripper metadata
    * URL of chapter index
    * The specific ripper, etc...

### Page
 * belongs_to Chapter
 * Page Number
   * Does not need to be a number, but should lexicographically sortable.
 * Image URL
 * Marked for space recovery

## Storage Usage, and recovery
Chapters that have been read will be marked for recovery unless marked as permenant.
When space is low on the server, marked chapters will be deleted in order of marking
until there is enough space on the device to do whatever needs to be done.

When a chapter is deleted, its page images are deleted, but all rows and metadata are
retained, so the chapter can be easily downloaded if requested.
Any built chapters that have been marked, will have their comic archive deleted,
since these can be easily rebuilt.

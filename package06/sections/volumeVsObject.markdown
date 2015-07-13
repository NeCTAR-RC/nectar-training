---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

In summary, the  main differences between *volume* and *object* store are:

**File Access**    
*Volume* or *Block* storage can be seen as what we know as a partition of a harddrive (or a whole hard drive), containing a lot of files in one continuous block. Files are accessed with traditional file access methods.
In the *Object Storage*, files may be spread over several hard-drives. An *object* is accessed using a *http* based interface. 

**Distribution**    
*Object Storage* is a per-file based storage system which stores each file at several locations --- you won’t know where exactly the individual files are stored, they may even not all be on the same harddrive. In contrast, *Volume Storage* is one block of storage which contains *several* files, located at *one* location.



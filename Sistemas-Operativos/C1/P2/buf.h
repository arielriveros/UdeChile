typedef struct buffer *Buffer;

Buffer makeBuffer(int size);
void destroyBuffer(Buffer buf);
void* get(Buffer buf);
void put(Buffer buf, void *ptr);


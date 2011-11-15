#ifndef __libdetenc_h__

char const *detect_encoding (FILE *fp);
char const *detect_bom (FILE *fp);

#define __libdetenc_h__
#endif

#include <stdio.h>
#include <string.h>
#include "libdetenc.h"
#include "detectors.h"

const char BOM_UTF_8[3] = {0xEF, 0xBB, 0xBF};
const char BOM_UTF_16BE[2] = {0xFE, 0xFF};
const char BOM_UTF_16LE[2] = {0xFF, 0xFE};

char const *detect_encoding (FILE *fp) {
  long interesting_offset;

  const char* bom = detect_bom(fp);
  if(strcmp(bom, ENC_UNKNOWN) != 0) {
    return bom;
  }

  interesting_offset = find_first_non_us_ascii(fp);
  if (interesting_offset == -1)
    return ENC_US_ASCII;

  fseek(fp, interesting_offset, SEEK_SET);
  if (is_utf_8(fp))
    return ENC_UTF_8;

  fseek(fp, interesting_offset, SEEK_SET);
  if (is_iso_8859_15(fp))
    return ENC_ISO_8859_15;

  fseek(fp, interesting_offset, SEEK_SET);
  if (is_windows_1252(fp))
    return ENC_WINDOWS_1252;

  return ENC_UNKNOWN;
}

char const *detect_bom (FILE *fp) {
  long previous_offset;
  char header[3] = {0,0,0};
  const char* encoding = ENC_UNKNOWN;

  previous_offset = ftell(fp);
  fseek(fp, 0, SEEK_SET);
  fread(&header, sizeof(char), 3, fp);
  fseek(fp, previous_offset, SEEK_SET);
  if(strncmp(BOM_UTF_8, header, 3) == 0) {
    encoding = ENC_UTF_8;
  } else if (strncmp(BOM_UTF_16LE, header, 2) == 0) {
    encoding = ENC_UTF_16LE;
  } else if (strncmp(BOM_UTF_16BE, header, 2) == 0) {
    encoding = ENC_UTF_16BE;
  }
  return encoding;
}
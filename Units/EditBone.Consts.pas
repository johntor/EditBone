unit EditBone.Consts;

interface

uses
  System.SysUtils, BCControls.ComboBox;

const
  EDITBONE_NONE_CHAR = #0;
  EDITBONE_BACKSPACE_CHAR = #8;
  EDITBONE_TAB_CHAR = #9;
  EDITBONE_LINEFEED = #10;
  EDITBONE_CARRIAGE_RETURN = #13;
  EDITBONE_ESCAPE = #27;
  EDITBONE_SPACE_CHAR = #32;

  EDITBONE_MAIN_CAPTION_DOCUMENT = ' - [%s]';
  EDITBONE_STATUS_BAR_PANEL_WIDTH = 88;
  EDITBONE_STATUS_BAR_MACRO_PANEL = 0;
  EDITBONE_STATUS_BAR_CARET_POSITION_PANEL = 1;
  EDITBONE_STATUS_BAR_INSERT_KEYSTATE_PANEL = 2;
  EDITBONE_STATUS_BAR_MODIFIED_INFO_PANEL = 3;
  EDITBONE_STATUS_BAR_HINT_PANEL = 4;
  { Document tab sheet item tags }
  EDITBONE_DOCUMENT_EDITOR_TAG = 0;
  EDITBONE_DOCUMENT_SPLIT_EDITOR_TAG = 1;
  EDITBONE_DOCUMENT_XML_TREE_TAG = 2;
  EDITBONE_DOCUMENT_VERTICAL_SPLITTER_TAG = 3;
  EDITBONE_DOCUMENT_COMBOBOX_SEARCH_TEXT_TAG = 4;
  EDITBONE_DOCUMENT_HORIZONTAL_SPLITTER_TAG = 5;
  EDITBONE_DOCUMENT_SEARCH_PANEL_TAG = 6;
  EDITBONE_DOCUMENT_LABEL_SEARCH_RESULT_COUNT_TAG = 7;

  EDITBONE_TITLE_BAR_MENU = 0;
  EDITBONE_TITLE_BAR_CAPTION = 1;
  EDITBONE_TITLE_BAR_FILE_NAME = 2;
  EDITBONE_TITLE_BAR_SPACING1 = 3;
  EDITBONE_TITLE_BAR_ENCODING = 4;
  EDITBONE_TITLE_BAR_SPACING2 = 5;
  EDITBONE_TITLE_BAR_HIGHLIGHTER = 6;
  EDITBONE_TITLE_BAR_SPACING3 = 7;
  EDITBONE_TITLE_BAR_COLORS = 8;
  EDITBONE_TITLE_BAR_SPACING4 = 9;

  EXTENSION_JSON = 1;
  EXTENSION_XML = 2;
  EXTENSION_SQL = 3;

  ENCODING_ANSI = 0;
  ENCODING_ASCII = 1;
  ENCODING_BIG_ENDIAN_UNICODE = 2;
  ENCODING_UNICODE = 3;
  ENCODING_UTF7 = 4;
  ENCODING_UTF8 = 5;
  ENCODING_UTF8_WITHOUT_BOM = 6;

  ENCODING_CAPTIONS: array [0 .. 6] of string = ('ANSI', 'ASCII', 'Big Endian Unicode', 'Unicode', 'UTF-7', 'UTF-8', 'UTF-8 without BOM');

function EncodingToText(AEncoding: System.SysUtils.TEncoding): string;
procedure GetEncodingItems(AComboBox: TBCComboBox);

implementation

uses
  BCEditor.Encoding;

function EncodingToText(AEncoding: System.SysUtils.TEncoding): string;
begin
  if AEncoding = TEncoding.ASCII then
    Result := ENCODING_CAPTIONS[ENCODING_ASCII]
  else
  if AEncoding = TEncoding.BigEndianUnicode then
    Result := ENCODING_CAPTIONS[ENCODING_BIG_ENDIAN_UNICODE]
  else
  if AEncoding = TEncoding.Unicode then
    Result := ENCODING_CAPTIONS[ENCODING_UNICODE]
  else
  if AEncoding = TEncoding.UTF7 then
    Result := ENCODING_CAPTIONS[ENCODING_UTF7]
  else
  if AEncoding = TEncoding.UTF8 then
    Result := ENCODING_CAPTIONS[ENCODING_UTF8]
  else
  if AEncoding = BCEditor.Encoding.TEncoding.UTF8WithoutBOM then
    Result := ENCODING_CAPTIONS[ENCODING_UTF8_WITHOUT_BOM]
  else
    Result := ENCODING_CAPTIONS[ENCODING_ANSI];
end;

procedure GetEncodingItems(AComboBox: TBCComboBox);
var
  i: Integer;
begin
  AComboBox.Clear;
  for i := 0 to 6 do
    AComboBox.Items.Add(ENCODING_CAPTIONS[i]);
end;

end.

unit notesorm;

{$mode objfpc}{$H+}

interface

uses
  Classes
  , SysUtils
  , SynCommons
  , mORMot;

type

  { TNote }

  TNote = class(TSQLRecord)
  private
    FBody: RawUTF8;
    FTitle: RawUTF8;
  published
    property Body: RawUTF8 read FBody write FBody;
    property Title: RawUTF8 index 80 read FTitle write FTitle;
  end;

implementation

end.


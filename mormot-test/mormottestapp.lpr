program mormottestapp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp, notesorm, SynSQLite3Static, mORMot,
  mORMotSQLite3, notesguitab;

type

  { TMormotTestApp }

  TMormotTestApp = class(TCustomApplication)
  protected
    procedure DoRun; override;
  private
    procedure TestMormotNote(ARest: TSQLRest);
    procedure TestMormotNoteRetrieve(ARest: TSQLRest);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TMormotTestApp }

procedure TMormotTestApp.DoRun;
var
  ErrorMsg: String;
  VRestServer: TSQLRestServerDB;
  VRestClient: TSQLRestClientURI;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  VRestServer := TSQLRestServerDB.CreateWithOwnModel([notesorm.TNote],
    'mormot-test.db');
  VRestClient := TSQLRestClientURIDll.Create(
    TSQLModel.Create(VRestServer.Model), @URIRequest);
  try
    VRestServer.ExportServer;
    USEFASTMM4ALLOC := True;
    VRestServer.CreateMissingTables();
    VRestClient.Model.Owner := VRestClient;
    TestMormotNote(VRestClient);
    WriteLn('Nota salva. mORMmot testado.');
    ReadLn;
  finally
    VRestClient.Free;
    VRestServer.Free;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;



  // stop program loop
  Terminate;
end;

procedure TMormotTestApp.TestMormotNote(ARest: TSQLRest);
var
  VNote: notesorm.TNote;
begin
  VNote := TNote.Create;
  VNote.Body := 'Sample 1. This is a sample note.';
  ARest.Add(VNote, True);
end;

procedure TMormotTestApp.TestMormotNoteRetrieve(ARest: TSQLRest);
begin

end;

constructor TMormotTestApp.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TMormotTestApp.Destroy;
begin
  inherited Destroy;
end;

procedure TMormotTestApp.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TMormotTestApp;
begin
  Application:=TMormotTestApp.Create(nil);
  Application.Title:='mORMot Test App';
  Application.Run;
  Application.Free;
end.


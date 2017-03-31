unit notesguitab;

{$mode objfpc}{$H+}

interface

uses
  Classes
  , SysUtils
  , mORMot
  , notesorm;

type

  TNoteAction = (naNoAction, naMark);

  TNoteActions = set of TNoteAction;

  TNotesTabParameters = object(TSQLRibbonTabParameters)
    Actions: TNoteActions;
  end;

const

  NoteTabs: array[0..0] of TNotesTabParameters = (
    (
      Table: notesorm.TNote;
      Select: 'Title,Body';
      Group: 0;
      FieldWidth: 'gIZ';
      ShowID: True;
      ReverseOrder: True;
      Layout: llClient;
      Actions: [naMark]
    )
  );

implementation

end.


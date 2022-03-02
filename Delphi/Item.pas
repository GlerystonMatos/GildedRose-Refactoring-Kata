unit Item;

interface

type
  TItem = class(TObject)
  private
    FName: string;
    FSellIn: Integer;
    FQuality: Integer;
  public
    constructor Create(const AName: string; const ASellIn, AQuality: Integer);

    function IsLendario: Boolean;
    function IsAgedBrie: Boolean;
    function PossuiQualidade: Boolean;
    function IsBackstagePasses: Boolean;
    function ToString: string; override;
    function NaoPossuiValidade: Boolean;
    function NaoAtingiuQualidadeMaxima: Boolean;
    function NaoAumentaQualidadeComTempo: Boolean;

    procedure ZerarQualidade;
    procedure DecrementarSellIn;
    procedure IncrementarQualidade;
    procedure DecrementarQualidade;

    property Name: string read FName write FName;
    property SellIn: Integer read FSellIn write FSellIn;
    property Quality: Integer read FQuality write FQuality;
  end;

implementation

uses
  System.SysUtils;

{ TItem }

function TItem.NaoAtingiuQualidadeMaxima: Boolean;
begin
  Result := (FQuality < 50);
end;

function TItem.PossuiQualidade: Boolean;
begin
  Result := (FQuality > 0);
end;

constructor TItem.Create(const AName: string; const ASellIn, AQuality: Integer);
begin
  inherited Create;
  FName := AName;
  FSellIn := ASellIn;
  FQuality := AQuality;
end;

procedure TItem.DecrementarQualidade;
begin
  FQuality := FQuality - 1;
end;

procedure TItem.DecrementarSellIn;
begin
  FSellIn := FSellIn - 1;
end;

procedure TItem.IncrementarQualidade;
begin
  FQuality := (FQuality + 1);
end;

function TItem.IsAgedBrie: Boolean;
begin
  Result := (FName = 'Aged Brie');
end;

function TItem.IsBackstagePasses: Boolean;
begin
  Result := (FName = 'Backstage passes to a TAFKAL80ETC concert');
end;

function TItem.IsLendario: Boolean;
begin
  Result := (FName = 'Sulfuras, Hand of Ragnaros');
end;

function TItem.NaoAumentaQualidadeComTempo: Boolean;
begin
  Result := ((not IsAgedBrie) and (not IsBackstagePasses));
end;

function TItem.NaoPossuiValidade: Boolean;
begin
  Result := (FSellIn < 0);
end;

function TItem.ToString: string;
begin
  Result := Format('%s, %d, %d', [Name, SellIn, Quality]);
end;

procedure TItem.ZerarQualidade;
begin
  FQuality := FQuality - FQuality;
end;

end.

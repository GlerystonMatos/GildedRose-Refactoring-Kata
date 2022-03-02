unit GildedRose;

interface

uses
  Item,
  System.Generics.Collections;

type
  TGildedRose = class(TObject)
  private
    FItems: TObjectList<TItem>;
    procedure AtualizarItem(const AItem: TItem);
    procedure AtualizarSellIn(const AItem: TItem);
    procedure AtualizarQualidade(const AItem: TItem);
    procedure IncrementarQualidade(const AItem: TItem);
    procedure DecrementarQualidade(const AItem: TItem);
    procedure AumentarQualidadeComTempo(const AItem: TItem);
    procedure AtualizarQualidadeItensVencidos(const AItem: TItem);
  public
    constructor Create(const AItems: TObjectList<TItem>);
    procedure UpdateItem;
    property Items: TObjectList<TItem> read FItems;
  end;

implementation

{ TGildedRose }

constructor TGildedRose.Create(const AItems: TObjectList<TItem>);
begin
  inherited Create;
  FItems := AItems;
end;

procedure TGildedRose.UpdateItem;
var
  Indice: Integer;
begin
  for Indice := 0 to Pred(Items.Count) do
    AtualizarItem(Items[Indice]);
end;

procedure TGildedRose.AtualizarItem(const AItem: TItem);
begin
  AtualizarQualidade(AItem);
  AtualizarSellIn(AItem);
  AtualizarQualidadeItensVencidos(AItem);
end;

procedure TGildedRose.AtualizarQualidade(const AItem: TItem);
begin
  if (AItem.NaoAumentaQualidadeComTempo) then
    DecrementarQualidade(AItem)
  else
    AumentarQualidadeComTempo(AItem);
end;

procedure TGildedRose.AtualizarSellIn(const AItem: TItem);
begin
  if (not AItem.IsLendario) then
    AItem.DecrementarSellIn;
end;

procedure TGildedRose.AtualizarQualidadeItensVencidos(const AItem: TItem);
begin
  if (AItem.NaoPossuiValidade) then
  begin
    if (not AItem.IsAgedBrie) then
    begin
      if (not AItem.IsBackstagePasses) then
        DecrementarQualidade(AItem)
      else
        AItem.ZerarQualidade;
    end
    else
      IncrementarQualidade(AItem);
  end;
end;

procedure TGildedRose.DecrementarQualidade(const AItem: TItem);
begin
  if ((AItem.PossuiQualidade) and (not AItem.IsLendario)) then
    AItem.DecrementarQualidade;
end;

procedure TGildedRose.AumentarQualidadeComTempo(const AItem: TItem);
begin
  IncrementarQualidade(AItem);
  if (AItem.IsBackstagePasses) then
  begin
    if (AItem.SellIn < 11) then
      IncrementarQualidade(AItem);

    if (AItem.SellIn < 6) then
      IncrementarQualidade(AItem);
  end;
end;

procedure TGildedRose.IncrementarQualidade(const AItem: TItem);
begin
  if (AItem.NaoAtingiuQualidadeMaxima) then
    AItem.IncrementarQualidade;
end;

end.

# frozen_string_literal: true

require File.join("#{File.dirname(__FILE__)}/../lib", 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end
  end
  context 'sell-in attribute' do
    it 'reduces sell-in by 1 every day' do
      item = Item.new('item name', 5, 10)
      items = [item]
      stock = described_class.new(items)
      stock.update_quality

      expect(item.sell_in).to eq 4
    end
  end
  context 'quality attribute' do
    it 'can never be negative' do
      item = Item.new('item name', 0, 0)
      items = [item]
      stock = described_class.new(items)
      stock.update_quality

      expect(item.quality).to eq 0
    end

    it 'can never more than 50' do
      item = Item.new('item name', 20, 50)
      items = [item]
      gilded_rose = described_class.new(items)
      gilded_rose.update_quality

      expect(item.quality).to be <= 50
    end
  end
end

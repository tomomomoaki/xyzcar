class BodyType < ActiveHash::Base
  self.data = [
    { id: 1, name: nil },
    { id: 2, name: '軽自動車' },
    { id: 3, name: 'コンパクト' },
    { id: 4, name: 'セダン' },
    { id: 5, name: 'ワゴン' },
    { id: 6, name: 'SUV' },
    { id: 7, name: 'ミニバン' },
    { id: 8, name: 'クーペ' },
    { id: 9, name: 'オープンカー' }
  ]
end
class Evaluation < ActiveHash::Base
  self.data = [
    { id: 1, name: '' },
    { id: 2, name: '超おすすめ' },
    { id: 3, name: 'どちらかといえばおすすめ' },
    { id: 4, name: '良いとも悪いとも言えない' },
    { id: 5, name: 'どちらかといえばおすすめしない' },
    { id: 6, name: 'おすすめしない' }
  ]
end

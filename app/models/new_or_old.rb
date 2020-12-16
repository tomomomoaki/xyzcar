class NewOrOld < ActiveHash::Base
  self.data = [
    { id: 1, name: nil },
    { id: 2, name: '新車' },
    { id: 3, name: '新古車' },
    { id: 4, name: '中古（1年未満）' },
    { id: 5, name: '中古（3年未満）' },
    { id: 6, name: '中古（5年未満）' },
    { id: 7, name: '中古（5年以上）' }
  ]
end
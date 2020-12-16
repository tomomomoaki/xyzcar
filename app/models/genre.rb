class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '購入レビュー（乗車歴、1年以上）' },
    { id: 3, name: '購入レビュー（乗車歴、1年未満）' },
    { id: 4, name: '試乗レビュー' },
    { id: 5, name: 'ニュース' },
    { id: 6, name: '質問' },
    { id: 7, name: 'カスタム' },
    { id: 8, name: '何気ない投稿' }
  ]
end

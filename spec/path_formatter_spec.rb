describe Netdocuments::PathFormatter do

  subject { Netdocuments::PathFormatter.new('a/b/c/d')}


  it 'should format the path' do
    expect(subject.format).to eq('a /  b /  c / d')
  end
end

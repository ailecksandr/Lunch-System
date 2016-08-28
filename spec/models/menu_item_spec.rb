require 'rails_helper'

describe MenuItem do
  context 'relations' do
    it { should belong_to(:order) }
    it { should belong_to(:meal) }
  end
end

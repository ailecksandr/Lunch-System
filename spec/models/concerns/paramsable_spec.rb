require 'rails_helper'
include Paramsable

describe Paramsable do
  before do
    expect(JSON).to receive(:parse).and_return({
      'meals' => [{
        'name' => 'Common Borsch',
        'meal_type' => 'first_meal'
      }]
    })
  end

  describe '#meals_params_from_file' do
    before do
      @params = {
        'first_meal' => [{
          name: 'Common Borsch',
          meal_type: 'first_meal'
        }],
        'main_meal' => [],
        'drink' => []
      }
    end

    it { expect(meals_params_from_file).to eq @params }
  end
end
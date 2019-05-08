require 'rails_helper'

RSpec.describe Document, type: :model do
  
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }

  describe '#validations' do
    subject { Document.new }

    context 'when is not valid' do
      it { expect(subject.valid?).to be_falsey }
    end

    context 'when is valid' do
      subject { build(:document) }

      it { expect(subject.valid?).to be_truthy }
    end
  end
end

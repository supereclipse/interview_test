require 'rspec'
require './combination_picker.rb'

RSpec.describe CombinationPicker do
  subject { described_class.new(n, initial_state, target_state, restricted_combinations).pick }

  let(:n) { 3 }
  let(:initial_state) { %w[0 0 0] }
  let(:target_state) { %w[3 3 3] }
  let(:restricted_combinations) {[]}

  RSpec.shared_examples 'finds_path' do
    it 'returns path' do
      expect(subject).not_to be_nil
      expect(subject.first).to eq(initial_state)
      expect(subject.last).to eq(target_state)
    end
  end

  context 'when path is findable' do
    let(:restricted_combinations) { [%w[0 0 1], %w[1 0 0]] }

    context 'when initial_state = target_state' do
      let(:initial_state) { %w[3 3 3] }

      it 'returns path' do
        expect(subject).to eq([initial_state])
      end
    end

    context 'when initial_state > target_state' do
      let(:initial_state) { %w[5 5 5] }

      it_behaves_like 'finds_path'
    end

    context 'when initial_state < target_state' do
      let(:initial_state) { %w[0 0 0] }

      it_behaves_like 'finds_path'
    end
  end

  context 'when path is not findable' do
    let(:restricted_combinations) { [%w[4 3 3], %w[2 3 3], %w[3 4 3], %w[3 2 3], %w[3 3 4], %w[3 3 2]] }

    it 'returns nil' do
      expect(subject).to be_nil
    end
  end

  context 'works with every possible n' do
    (1..6).each do |n|
      context "works with n = #{n}" do
        let(:n) { n }
        let(:initial_state) { Array.new(n, '0') }
        let(:target_state) { Array.new(n, '9') }

        it_behaves_like 'finds_path'
      end
    end
  end
end

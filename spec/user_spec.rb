require 'spec_helper'

describe 'user' do
  subject! do
    User.new(attributes: {
               id:         User.count,
               first_name: 'Bruce',
               last_name:  'Dickinson' },
             sessions: {
               sessionsCount: 1,
               totalTime: 15,
               longestSession: 15,
               browsers: ['Chrome'],
               dates: ['2017-02-27'] })
  end

  let(:user_ie) do
    User.new(attributes: {},
             sessions: {
                 browsers: ['Internet Explorer'] })
  end

  describe '.count' do
    it 'should return count of users' do
      expect(User.count).to eq 1
    end

    it 'change count for user' do
      expect{ User.new(attributes:{}, sessions: {} ) }.to change { User.count }.by 1
    end
  end

  describe '#update' do
    let(:user) { User.instance }

    let(:update) do
      user.update do |user|
        user.sessions[:sessionsCount] += 1
      end
    end

    it 'should update data' do
      expect{ update }.to change { user.sessions[:sessionsCount] }.by 1
    end
  end

  describe '#used_ie?' do
    it 'should return true' do
      expect(user_ie.used_ie?).to be_truthy
    end

    it 'should return false' do
      expect(User.instance.used_ie?).to be_falsey
    end
  end

  describe '#always_used_chrome?' do
    it 'should return true' do
      expect(User.instance.always_used_chrome?).to be_truthy
    end

    it 'should return false' do
      expect(user_ie.always_used_chrome?).to be_falsey
    end
  end
end

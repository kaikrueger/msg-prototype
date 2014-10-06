require 'spec_helper'

describe 'Device pages' do

  subject { page }

  describe 'index' do
    let(:device) { FactoryGirl.create(:device) }

    before do
      sign_in device.user
      visit devices_path
    end

    it { should have_title('My Devices') }
    it { should have_content('My Devices') }

  end

  describe 'edit' do
    let(:device) { FactoryGirl.create(:device) }

    before do
      sign_in device.user
      visit edit_device_path(device)
    end

    describe 'page' do
      it { should have_title('Edit device') }
    end
  end
end


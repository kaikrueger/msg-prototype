require 'spec_helper'

describe 'Device pages' do

  subject { page }

  describe 'index' do
    let(:device) { FactoryGirl.create(:device) }

    before do
      sign_in device.user
      visit devices_path
    end

    it { should have_title('Devices') }
    it { should have_content('Devices') }

  end

  describe 'edit' do
    let(:device) { FactoryGirl.create(:device) }

    before do
      sign_in device.user
      visit edit_device_path(device)
    end

    describe 'page' do
      it { should have_title('Device Update') }
    end
  end
end


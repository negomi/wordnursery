require 'spec_helper'

describe "Pages" do

  describe "Home" do

    it "displays the content 'wordnursery'" do

      visit root_path
      expect(page).to have_content('wordnursery')
    end

  end
end

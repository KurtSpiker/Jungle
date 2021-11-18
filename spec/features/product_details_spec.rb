require 'rails_helper'

RSpec.feature "Click on a product to see its details", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

    scenario "Can click on one product and be redirected to product details page" do
      visit root_path

      page.all(".product .actions a")[0].click

      sleep 1

      save_screenshot
      expect(page).to have_css '.products-show'
      expect(page).to have_css("img[src*='apparel1.jpg']")
  end
end
require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @application_1 = Application.create!(name: "Billy", street: "Maritime Lane", city: "Springfield", state: "Virginia", zip: "22153", description: "Loving and likes to walk", status: "In Progress")
      
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)
  end

  describe "User Story 12: Approving a Pet for Adoption" do
    describe "As a visitor, when I visit an admin application page" do
      it "For every pet on the application, I see a button to approve the application for that pet" do
        visit "/applications/#{@application_1.id}"
        fill_in "Search", with: "Ba"
        click_on("Search")
        
        within "#pet-#{@pet_1.id}" do
          click_button("Adopt this Pet")
        end

        within "#appliedPets" do
          fill_in("add_qualifications", with: "I also have a dog named Lola who is a showgirl.")
          click_button("Submit")
        end
        visit "/admin/applications/#{@application_1.id}"

        save_and_open_page

        within "#pet-#{@pet_1.id}" do
          expect(page).to have_button("Approve")
        end
      end

      it "When I click the button, I am taken back to the admin app show page where I don't see a button to approve, but do see an indicator saying the pet has been approved" do

      end
    end
  end



end


# 12. Approving a Pet for Adoption

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved


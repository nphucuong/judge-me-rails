class AddReviewerNameToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :reviewer_name,  :string
  end
end

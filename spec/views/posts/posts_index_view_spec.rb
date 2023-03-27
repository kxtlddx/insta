require 'rails_helper'

RSpec.describe 'posts/index.html.erb', type: :view do

  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:current_user) { create(:user) }

  before do
    assign(:post, post)
    render
  end

  it 'displays the post' do
    expect(rendered).to include(post.description)
  end

  context 'when user is signed in' do
    before { sign_in create(:user) }

    it 'displays the posts container' do
      expect(rendered).to have_selector('#posts-container')
    end

    it 'displays all the posts' do
      expect(rendered).to match /#{Post.first.description}}/
      expect(rendered).to match /#{Post.last.description}}/
    end

    context 'when there are more posts than posts per page' do
      before { assign(:posts, [create(:post), create(:post), create(:post)]) }

      it 'displays the load more button' do
        expect(rendered).to have_selector('.load-more-posts')
      end

      context 'when clicking the load more button' do
        before { get :index, params: { offset: 2 } }

        it 'loads more posts' do
          expect(assigns[:posts].size).to eq(3)
        end

        it 'renders the new posts' do
          expect(response.body).to match /#{assigns[:posts].last.description}}/
        end
      end
    end

    context 'when there are no posts' do
      before { assign(:posts, []) }

      it 'displays a message saying there are no posts' do
        expect(rendered).to have_content('There are no posts.')
      end
    end
  end

  context 'when user is not signed in' do
    it 'does not display the posts container' do
      expect(rendered).not_to have_selector('#posts-container')
    end

    it 'displays all the posts' do
      expect(rendered).to match /#{Post.first.description}}/
      expect(rendered).to match /#{Post.last.description}}/
    end

    context 'when there are more posts than posts per page' do
      before { assign(:posts, [create(:post), create(:post), create(:post)]) }

      it 'does not display the load more button' do
        expect(rendered).not_to have_selector('.load-more-posts')
      end
    end
  end
end
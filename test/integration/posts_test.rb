require "test_helper"

class PostsTest < ActionDispatch::IntegrationTest
  test "index displays posts" do
    Post.create!(author: "Alice", body: "First post", image: "https://example.com/a.png")
    Post.create!(author: "Bob", body: "Second post", image: "https://example.com/b.png")

    get "/posts"

    assert_response :success
    assert_select "h4", text: "Alice"
    assert_select "h4", text: "Bob"
    assert_select "p", text: "First post"
    assert_select "p", text: "Second post"
    assert_select "form button", text: "Delete", count: 2
  end

  test "new displays post form fields" do
    get "/posts/new"

    assert_response :success
    assert_select "form"
    assert_select "input[name='post[author]']"
    assert_select "input[name='post[body]']"
    assert_select "input[name='post[image]']"
    assert_select "input[type='submit'][value='Create Post']"
  end

  test "create adds a post and redirects to index" do
    assert_difference("Post.count", 1) do
      post "/posts", params: {
        post: {
          author: "Charlie",
          body: "Created from test",
          image: "https://example.com/c.png"
        }
      }
    end

    assert_response :redirect
    assert_redirected_to "/posts"

    follow_redirect!
    assert_response :success
    assert_select "h4", text: "Charlie"
    assert_select "p", text: "Created from test"
  end

  test "destroy removes a post and redirects to index" do
    post_record = Post.create!(author: "Delete Me", body: "Soon gone", image: "https://example.com/d.png")

    assert_difference("Post.count", -1) do
      delete "/posts/#{post_record.id}"
    end

    assert_response :redirect
    assert_redirected_to "/posts"

    follow_redirect!
    assert_response :success
    assert_select "h4", text: "Delete Me", count: 0
  end
end

require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { author: @comment.author, comment_text: @comment.comment_text }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should update comment" do
    patch :update, id: @comment, comment: { author: @comment.author, comment_text: @comment.comment_text }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to comments_path
  end
end

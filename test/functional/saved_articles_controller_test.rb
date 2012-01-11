require 'test_helper'

class SavedArticlesControllerTest < ActionController::TestCase
  setup do
    @saved_article = saved_articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saved_articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saved_article" do
    assert_difference('SavedArticle.count') do
      post :create, saved_article: @saved_article.attributes
    end

    assert_redirected_to saved_article_path(assigns(:saved_article))
  end

  test "should show saved_article" do
    get :show, id: @saved_article.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saved_article.to_param
    assert_response :success
  end

  test "should update saved_article" do
    put :update, id: @saved_article.to_param, saved_article: @saved_article.attributes
    assert_redirected_to saved_article_path(assigns(:saved_article))
  end

  test "should destroy saved_article" do
    assert_difference('SavedArticle.count', -1) do
      delete :destroy, id: @saved_article.to_param
    end

    assert_redirected_to saved_articles_path
  end
end

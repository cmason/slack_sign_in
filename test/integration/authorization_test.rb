require "test_helper"

class SlackSignIn::AuthorizationTest < ActionDispatch::IntegrationTest
  test "redirecting to Slack for authorization" do
    post slack_sign_in.authorization_url, params: {proceed_to: "http://www.example.com/sessions"}

    assert_response :redirect
    assert_match SlackSignIn::AUTHORIZE_URL, response.location

    assert_equal FAKE_SLACK_CLIENT_ID, url_params[:client_id]
    assert_equal "code", url_params[:response_type]
    assert_equal "http://www.example.com/slack_sign_in/callback", url_params[:redirect_uri]
    assert_equal "test.scope test.scope2", url_params[:scope]

    assert_equal "http://www.example.com/sessions", flash[:proceed_to]
    assert_equal url_params[:state], flash[:state]
  end

  private

  def url_params
    @_url_params ||= Rack::Utils.parse_query(
      URI(response.location).query
    ).symbolize_keys
  end
end

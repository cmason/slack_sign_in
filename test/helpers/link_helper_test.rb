require "test_helper"

class SlackSignIn::LinkHelperTest < ActionView::TestCase
  test "generating a login link" do
    link = slack_sign_in_link(proceed_to: "https://www.example.com/sessions")

    assert_dom_equal <<-HTML, link
      <form class="button_to" method="post" action="/slack_sign_in/authorization?proceed_to=https%3A%2F%2Fwww.example.com%2Fsessions">
        <button type="submit">
          #{slack_sign_in_image}
        </button>
      </form>
    HTML
  end

  test "generating a login link with options" do
    link = slack_sign_in_link(
      proceed_to: "https://www.example.com/sessions",
      class: "text-blue-400"
    )

    assert_dom_equal <<-HTML, link
      <form class="button_to" method="post" action="/slack_sign_in/authorization?proceed_to=https%3A%2F%2Fwww.example.com%2Fsessions">
        <button class="text-blue-400" type="submit">
        #{slack_sign_in_image}
        </button>
      </form>
    HTML
  end

  test "generating a login link with text" do
    link = slack_sign_in_link(
      "Sign In!",
      proceed_to: "https://www.example.com/sessions"
    )

    assert_dom_equal <<-HTML, link
      <form class="button_to" method="post" action="/slack_sign_in/authorization?proceed_to=https%3A%2F%2Fwww.example.com%2Fsessions">
        <input type="submit" value="Sign In!" />
      </form>
    HTML
  end

  test "generating a login link with text and options" do
    link = slack_sign_in_link(
      "Sign In!",
      proceed_to: "https://www.example.com/sessions",
      data: {confirm: "You sure?"}
    )

    assert_dom_equal <<-HTML, link
      <form class="button_to" method="post" action="/slack_sign_in/authorization?proceed_to=https%3A%2F%2Fwww.example.com%2Fsessions">
        <input data-confirm="You sure?" type="submit" value="Sign In!" />
      </form>
    HTML
  end

  test "generating a login link with a block" do
    link = slack_sign_in_link(proceed_to: "https://www.example.com/sessions") {
      "Some Block Text!"
    }

    assert_dom_equal <<-HTML, link
      <form class="button_to" method="post" action="/slack_sign_in/authorization?proceed_to=https%3A%2F%2Fwww.example.com%2Fsessions">
        <button type="submit">Some Block Text!</button>
      </form>
    HTML
  end

  test "generating a login link with a block and options" do
    link = slack_sign_in_link(proceed_to: "https://www.example.com/sessions", class: "rounded") {
      image_tag("my_cool_image.png")
    }

    assert_dom_equal <<-HTML, link
      <form class="button_to" method="post" action="/slack_sign_in/authorization?proceed_to=https%3A%2F%2Fwww.example.com%2Fsessions">
        <button class="rounded" type="submit">
          <img src="/images/my_cool_image.png" />
        </button>
      </form>
    HTML
  end

  test "generating the sign in with slack image" do
    assert_dom_equal <<-HTML, slack_sign_in_image
      <img alt="Sign in with Slack" height="40" width="172" srcset="https://platform.slack-edge.com/img/sign_in_with_slack.png 1x, https://platform.slack-edge.com/img/sign_in_with_slack@2x.png 2x" src="https://platform.slack-edge.com/img/sign_in_with_slack.png" />
    HTML
  end
end

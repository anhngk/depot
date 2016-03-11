require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders.(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["ka@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /1 x Programing Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["ka@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /<td>l&times;<\/td>\s*<td>Programing Ruby 1.9<\/td>/, mail.body.encoded
  end

end

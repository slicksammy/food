class Stats

  attr_reader :conn, :time_ago

  def initialize(time_ago)
    @time_ago = time_ago
    @conn = ActiveRecord::Base.connection
  end

  def orders
    results = conn.exec_query("select count(*) from orders where created_at > current_timestamp - interval '#{time_ago} minutes'")
    results.rows.flatten.first
  end

  def carts
    results = conn.exec_query("select count(*) from carts where created_at > current_timestamp - interval '#{time_ago} minutes'")
    results.rows.flatten.first
  end

  def users
    results = conn.exec_query("select count(*) from users where created_at > current_timestamp - interval '#{time_ago} minutes'")
    results.rows.flatten.first
  end

  def page_views
    results = conn.exec_query("select count(*) from page_visits where created_at > current_timestamp - interval '#{time_ago} minutes'")
    results.rows.flatten.first
  end

end

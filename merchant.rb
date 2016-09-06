class Merchant < ActiveRecord::Base
  default_scope -> { order(id: :desc) }
  has_many :items
  has_many :invoices

  def self.random
    order("RANDOM()").first
  end

  def self.most_items_merchant(quantity)
    all.sort_by(&:calculate_items).reverse[0...quantity.to_i]
  end

  def self.most_revenue_merchant(quantity)
    all.sort_by(&:calculate_revenue).reverse[0...quantity.to_i]
  end

  def self.revenue_to_merchant(id)
    invoice_ids         = Merchant.find(id).invoices.pluck(:id)
    paid_invoice_ids    = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    revenue             = InvoiceItem.where(invoice_id: paid_invoice_ids).sum("unit_price * quantity")
    {"revenue" => revenue }
  end

  def self.pending_invoice(id)
    invoice_ids         = Merchant.find(id).invoices.pluck(:id)
    pending_invoice_ids = Transaction.where(invoice_id: invoice_ids).where(result: "failed").pluck(:invoice_id)
    customer_ids        = Invoice.find(pending_invoice_ids).map{|invoice| invoice.customer.id}
    Customer.find(customer_ids)
  end

  def self.top_customer(id)
    invoice_ids         = Merchant.find(id).invoices.pluck(:id)
    paid_invoice_ids    = Transaction.where(invoice_id: invoice_ids).where(result: "success").pluck(:invoice_id)
    customer_ids_array  = Invoice.find(paid_invoice_ids).map { |invoice| invoice.customer_id }
    sales               = customer_ids_array.inject(Hash.new(0)) { |key,value| key[value] += 1; key }
    top_customer_id     = customer_ids_array.max_by { |value| sales[value] }
    Customer.find(top_customer_id)
  end

  private

    def calculate_items
      invoices.succesful.joins(:invoice_items).sum(:quantity)
    end

    def calculate_revenue
      invoices.succesful.joins(:invoice_items).sum("unit_price * quantity")
    end

end

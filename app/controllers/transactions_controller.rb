class TransactionsController < ApplicationController

  TextTransaction = Struct.new(:recipient_name, :currency_string, :time_string)
  def index
    if(!user_signed_in?)
      redirect_to('/401.html')
      return
    end
    @balance = '%.2f' % User.find(current_user.id).balance
    transactions = Transaction.all.where(:sender == User.find(current_user.id))
    if(transactions.length == 0)
      render('no-transactions')
      return
    else
      @transactions = Array.new
      transactions.each do |t|
        transaction = TextTransaction.new
        transaction.currency_string = t.currency.symbol + ('%.2f' % t.amount)
        transaction.recipient_name = t.recipient_name
        transaction.time_string = t.updated_at
        @transactions.push(transaction)
      end
    end
  end

  def show
  end

  def new
    @transaction = Transaction.new
    @currencies = Currency.all
    @balance = '%.2f' % User.find(current_user.id).balance
  end

  def create
    values = transaction_params
    values[:sort_code] = values[:sort_code].tr('-', '')

    @errors = error_messages(values)
    if(@errors.length > 0)
      @transaction = Transaction.new
      @currencies = Currency.all
      @balance = User.find(current_user.id).balance
      render(new_transaction_path)
      return
    else
      user = User.find(current_user.id)
      values[:sender] = user
      values[:currency] = Currency.find(values[:currency])

      @transaction = Transaction.new(values)

      if @transaction.save
        # If save succeeds, redirect to the index action
        user.balance = user.balance - values[:amount].to_d * values[:currency].valueInPounds.to_d
        user.save
        redirect_to(transactions_path)
      else
        # If save fails, redisplay the form so user can fix problems
        render('new')
      end
    end
  end




  private

  def error_messages(transaction_values)
    errors = Array.new
    validate_amount(transaction_values[:amount], errors)
    validate_currency(transaction_values[:currency], errors)
    validate_sender(current_user, errors)
    if(errors.length() == 0)
      validate_sufficient_funds(transaction_values[:amount].to_d, Currency.find(transaction_values[:currency]), errors)
    end
    validate_sort_code(transaction_values[:sort_code], errors)
    validate_name(transaction_values[:recipient_name], errors)
    validate_recipient(transaction_values[:sort_code], transaction_values[:account_number], errors)

    return errors
  end

  def get_recipient(transaction)
    if (transaction.sort_code == "050505")
      return User.find(transaction.account_number)
    else
      return nil
    end
  end

  def validate_recipient(sort_code, account_number, errors)
    if(!valid_nyala_recipient(sort_code, account_number))
      errors.push("That account does not exist.\nPlease check the account number and sort code before sending again.")
    end
  end

  def valid_nyala_recipient(sort_code, account_number)
    if(sort_code != "050505")
      return true
    else
      return User.exists?(account_number)
    end
  end

  def validate_currency(currency, errors)
    if(!Currency.exists? id: currency)
      errors.push("Invalid currency parameter")
    end
  end

  def validate_sender(sender, errors)
    if((sender == nil) || (!User.exists? id: sender.id))
      errors.push("You must be logged in to make a transaction")
    end
  end

  def validate_name(name, errors)
    if(name.blank?)
      errors.push("Name cannot be blank")
    end
  end

  def validate_sort_code(sort_code, errors)
    if(sort_code.length != 6)
      errors.push("Sort code must be 6 digits long")
    end
    if(!sort_code.match(/^(\d|-)*$/))
      errors.push("Sort code must contain only numbers and dashes")
    end
  end

  def validate_amount(amount, errors)
    if(!is_double(amount))
      errors.push("Amount must be a number")
      errors.push("Amount: " + amount)
    elsif(amount.to_d < 0)
      errors.push("Amount must not be negative")
    end
  end

  def validate_sufficient_funds(amount, currency, errors)
    if (!has_sufficient_funds(User.find(current_user.id),amount,currency))
      errors.push("You do not have sufficient funds to make this transaction")
    elsif amount <= 0
        errors.push("Amount must be positive")
    end
  end

  def has_sufficient_funds(user, amount, currency)
    return (user.balance >= amount * currency.valueInPounds)
  end

  def is_integer(string)
    return string.to_i.to_s == string
  end

  def is_double(string)
    return string.match(/^\d+\.\d{0,2}$/)
  end

  def transaction_params
    params.require(:transaction).permit(:sender, :amount, :currency, :recipient_name, :sort_code, :account_number)
  end
end

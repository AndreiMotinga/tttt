require "csv"

class Calculator
  attr_accessor :total
  attr_reader :files

  def initialize
    @files = Dir['./activities/*']
    @total = Hash.new(0)
  end

  def work
    files.each { |f| process_file(f) }
  end

  private

  def process_file(file)
    result = processed_csv(file)

    filename = "./processed/#{File.basename file}"
    create_processed_file(filename, result)
    create_processed_file("./processed/total.CSV", @total)
  end

  def create_processed_file(filename, result)
    CSV.open(filename, "wb") do |csv|
      csv << ["Transaction", "Amount"]
      result.each {|k, v| csv << [k, v]}
    end
  end

  def processed_csv(file)
    csv_text = File.read(file)
    csv = CSV.parse(csv_text, headers: true)
    result = csv.each_with_object(Hash.new(0)) do |row, res|
      name = trancated_name(row["Description"])
      amount = row["Amount"].to_f
      res[name] += amount
    end
    result = Hash[result.sort]
    @total = @total.merge(result) { |_, a_value, b_value| a_value + b_value }
    Hash[@total.sort]
    result
  end

  def trancated_name(name)
    return "MOTION RECRUITME PAYROLL" if name.match(/MOTION RECRUITME PAYROLL/)
    return "MTA" if name.match(/MTA/)
    return "MTA" if name.match(/UBER TECHNOLOGIES/)
    return "ATM WITHDRAWL" if name.match(/ATM WITHDRAW/)
    return "GOOGLE" if name.match(/ADWS7322355579/)
    return "ATM CASH DEPOSIT" if name.match(/ATM CASH DEPOSIT/)
    return "Payment to Chase card 9281(aarp)" if name.match(/Payment to Chase card ending in 9281/)
    return "Payment to Chase card 9553(freedom)" if name.match(/Payment to Chase card ending in 9553/)
    return "Payment to Chase card 7570(unlimited)" if name.match(/Payment to Chase card ending in 7570/)
    return "Payment to Chase card 7142(biz credit)" if name.match(/Payment to Chase card ending in 7142/)
    return "ATM CHECK DEPOSIT" if name.match(/ATM CHECK DEPOSIT/)
    return "to Iurie Gajev" if name.match(/to Iurie Gajev/)
    return "from IURIE GAJEV" if name.match(/from IURIE GAJEV/)
    return "Online Transfer to 3623" if name.match(/Online Transfer to CHK ...3623/)
    return "from ALLAN" if name.match(/from ALLAN I YARMULNIK/)
    return "to Allan Yarmulnik" if name.match(/to Allan Yarmulnik /)
    return "WESTERN UNION" if name.match(/WESTERN UNION/)
    return "Payment for EAD" if name.match(/USCIS DALLAS/)
    return "Transfer from 2616" if name.match(/Transfer from CHK ...2616/)
    return "Transfer from 3623" if name.match(/Online Transfer from CHK ...3623/)
    return "INSUFFICIENT FUNDS" if name.match(/INSUFFICIENT FUNDS/)
    return "HEROKU" if name.match(/HEROKU/)

    return "Bars and Food" if name.match(/25TH ASTORIA BAGEL AND ASTORIA NY/)
    return "Bars and Food" if name.match(/APPLEBEES/)
    return "Bars and Food" if name.match(/EMMONS DELI/)
    return "Bars and Food" if name.match(/NEW YORK SUPERMARKET/)
    return "Bars and Food" if name.match(/O'REILLY'S PUB & REST/)
    return "Bars and Food" if name.match(/BLACK DOOR/)
    return "Bars and Food" if name.match(/STOLOVAYA/)
    return "Bars and Food" if name.match(/TASTE OF RUSSIA/)
    return "Bars and Food" if name.match(/TGI_FRIDAYS/)
    return "Bars and Food" if name.match(/WALGREENS/)
    return "Bars and Food" if name.match(/ACE WINE & LIQUOR./)
    return "Bars and Food" if name.match(/C-TOWN SUPERMARKET/)
    return "Bars and Food" if name.match(/MCDONALD'S /)
    return "Bars and Food" if name.match(/BURGER KING/)
    return "Bars and Food" if name.match(/CAFE OLYMPIA/)
    return "Bars and Food" if name.match(/CAFE MAX/)
    return "Bars and Food" if name.match(/DD\/BR/)
    return "Bars and Food" if name.match(/MERCURY BAR/)
    return "Bars and Food" if name.match(/SLATE RESTAURANT BAR BILL/)
    return "Bars and Food" if name.match(/SUBWAY/)
    return "Bars and Food" if name.match(/DUNKIN/)
    return "Bars and Food" if name.match(/KAFFE 1668/)
    return "Bars and Food" if name.match(/NEW YORK SUPERMARKET/)
    return "Bars and Food" if name.match(/HOY WONG RESTAURANT/)
    return "Bars and Food" if name.match(/PRET A MANGER/)
    name
  end
end

Calculator.new.work

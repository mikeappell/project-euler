require 'bigdecimal'
require 'prime'
require 'csv'

class SpiralArray
    attr_accessor :spiral
    
    def initialize(side_length, params = {})
        @clockwise = params.fetch(:clockwise, true)
        @spiral = Array.new(side_length) {Array.new(side_length)}
        @current_position = [(side_length / 2).ceil, (side_length / 2).ceil + 1] # Start one right of center #
        @end_position = @clockwise ? [0, side_length - 1] : [side_length - 1, side_length - 1]
        @spiral[@current_position[0]][@current_position[1] - 1] = 1
        @spiral[@current_position[0]][@current_position[1]] = 2
        @value_counter = 3
        
        if @clockwise
            while true do
                move_down
                move_left
                move_up
                move_right
                break if @current_position == @end_position
            end 
        else 
            while true do
                move_up
                move_left
                move_down
                move_right
                break if @current_position == @end_position
            end 
        end
    end
    
    def move_down
        while (@clockwise ? @spiral[@current_position[0]][@current_position[1] - 1] != nil : @spiral[@current_position[0]][@current_position[1] + 1] != nil)do
            @current_position = [@current_position[0] + 1, @current_position[1]]
            @spiral[@current_position[0]][@current_position[1]] = @value_counter
            @value_counter += 1
        end
    end
    
    def move_left
        while (@clockwise ? @spiral[@current_position[0] - 1][@current_position[1]] != nil : @spiral[@current_position[0] + 1][@current_position[1]] != nil) do
            @current_position = [@current_position[0], @current_position[1] - 1]
            @spiral[@current_position[0]][@current_position[1]] = @value_counter
            @value_counter += 1
            break if @current_position == @end_position
        end
    end
    
    def move_up
        while (@clockwise ? @spiral[@current_position[0]][@current_position[1] + 1] != nil : @spiral[@current_position[0]][@current_position[1] - 1] != nil) do
            @current_position = [@current_position[0] - 1, @current_position[1]]
            @spiral[@current_position[0]][@current_position[1]] = @value_counter
            @value_counter += 1
        end
    end
    
    def move_right
        while (@clockwise ? @spiral[@current_position[0] + 1][@current_position[1]] != nil : @spiral[@current_position[0] - 1][@current_position[1]] != nil) do
            @current_position = [@current_position[0], @current_position[1] + 1]
            @spiral[@current_position[0]][@current_position[1]] = @value_counter
            @value_counter += 1
            break if @current_position == @end_position
        end
    end
    
    def diagonals
        diagonal_list, @position_counter = [], 0
        while true do
            if @position_counter == (@spiral.size / 2).ceil
                diagonal_list << @spiral[@position_counter][@position_counter]
                break
            end
            diagonal_list << @spiral[@position_counter][@position_counter] << @spiral[@position_counter][-1 - @position_counter] << @spiral[-1 - @position_counter][@position_counter] << @spiral[-1 - @position_counter][-1 - @position_counter]
            @position_counter += 1
        end
        diagonal_list
    end
end

class Array
    def sum
        self.inject(:+)
    end
    
    def exclude(*items)
        new_array = Array.new(self)
        items.flatten.each do |item|
            new_array.delete(item)
        end
        new_array
    end
end

class Range
    def exclude(*items)
        new_array = self.to_a
        items.flatten.each do |item|
            new_array.delete(item)
        end
        new_array
    end
end

def alphabetical_word_value(word_to_check)
    word_to_check.chars.inject(0) {|value, letter| value += (letter.ord - 64)}
end

def nth_fibnoacci(nth)
    return 1 if nth == 1 || nth == 2
  fibonacci_sequence = [1,1]
  (3..nth).each do |i|
    fibonacci_sequence << fibonacci_sequence[-1] + fibonacci_sequence[-2]
  end
  fibonacci_sequence.last
end

def factors(number_to_analyze, proper = false)
    divisors = []
    cutoff = proper ? (number_to_analyze / 2.0).ceil : number_to_analyze
    (1..cutoff).each {|num| divisors << num if number_to_analyze % num == 0}
    divisors
end

def factorial(number_to_factorialize)
    return 1 if number_to_factorialize == 1
    (2..number_to_factorialize).inject(:*)
end

def integer_to_word_string(number)
    number_string = []
    case number
        when 100..199
            number_string << "one hundred"
            number -= 100
            number_string << "and" unless number == 0
        when 200..299
            number_string << "two hundred"
            number -= 200
            number_string << "and" unless number == 0
        when 300..399
            number_string << "three hundred"
            number -= 300
            number_string << "and" unless number == 0
        when 400..499
            number_string << "four hundred"
            number -= 400
            number_string << "and" unless number == 0
        when 500..599
            number_string << "five hundred"
            number -= 500
            number_string << "and" unless number == 0
        when 600..699
            number_string << "six hundred"
            number -= 600
            number_string << "and" unless number == 0
        when 700..799
            number_string << "seven hundred"
            number -= 700
            number_string << "and" unless number == 0
        when 800..899
            number_string << "eight hundred"
            number -= 800
            number_string << "and" unless number == 0
        when 900..999
            number_string << "nine hundred"
            number -= 900
            number_string << "and" unless number == 0
        when 1000
            number_string << "one thousand"
            number -= 1000
    end
    case number
        when 20..29
            number_string << "twenty"
            number -= 20
        when 30..39
            number_string << "thirty"
            number -= 30
        when 40..49
            number_string << "forty"
            number -= 40
        when 50..59
            number_string << "fifty"
            number -= 50
        when 60..69
            number_string << "sixty"
            number -= 60
        when 70..79
            number_string << "seventy"
            number -= 70
        when 80..89
            number_string << "eighty"
            number -= 80
        when 90..99
            number_string << "ninety"
            number -= 90
    end
    case number
        when 1 then number_string << "one"
        when 2 then number_string << "two"
        when 3 then number_string << "three"
        when 4 then number_string << "four"
        when 5 then number_string << "five"
        when 6 then number_string << "six"
        when 7 then number_string << "seven"
        when 8 then number_string << "eight"
        when 9 then number_string << "nine"
        when 10 then number_string << "ten"
        when 11 then number_string << "eleven"
        when 12 then number_string << "twelve"
        when 13 then number_string << "thirteen"
        when 14 then number_string << "fourteen"
        when 15 then number_string << "fifteen"
        when 16 then number_string << "sixteen"
        when 17 then number_string << "seventeen"
        when 18 then number_string << "eighteen"
        when 19 then number_string << "nineteen"
    end
    number_string.join(" ")
end

def prime?(number_to_test)
    return false if number_to_test <= 1
    # return true if number_to_test == 2
    (2..Math::sqrt(number_to_test).round).each do |num|
        return false if number_to_test % num == 0
    end
    true
end

def get_nth_prime(number_to_test)
    prime = 1
    number_to_test.times do |num|
        while true do
            prime += 1
            break if prime?(prime)
        end
    end
    prime
end

def pentagonal?(pn)
  x = (1 + Math::sqrt(1 - (-24*pn))) / 6
    x % 1 == 0 && x > 0
end

def triangular?(tn)
    x = (1 + Math::sqrt(1 + (8*tn))) / 2
    x % 1 == 0 && x > 0
end

def hexagonal?(hn)
    x = (1 + Math::sqrt(1 + (8*hn))) / 4
    x % 1 == 0 && x > 0
end

def square?(sq)
    x = Math::sqrt(sq)
    x % 1 == 0 && x > 0
end

def heptagonal?(hn)
    x = ((3 + Math::sqrt(9 + (40 * hn))) / 10)
    x % 1 == 0 && x > 0
end

def octagonal?(on)
    x = ((2 + Math::sqrt(4 + (12*on))) / 6)
    x % 1 == 0 && x > 0
end

def to_pentagonal(num)
    (num * ((3 * num) - 1)) / 2
end

def to_triangular(num)
    (num * (num + 1)) / 2
end

def to_hexagonal(num)
    num * ((2 * num) - 1)
end

def to_heptagonal(num)
    (num * ((5 * num) - 3)) / 2
end

def to_octagonal(num)
    num * ((3 * num) - 2)
end

def palindrome?(string_to_test)
    string_to_test == string_to_test.reverse ? true : false
end

def to_binary(number_to_convert)
    binary = ""
    while number_to_convert > 0 do
        number_to_convert % 2 == 1 ? binary += "1" : binary += "0"
        number_to_convert /= 2
    end
    binary
end

def create_primes_list_and_sieve(list_size, prime_minimum = 0)
    primes_list, primes_sieve = [], Array.new(list_size)
    if prime_minimum == 0
        Prime.each(list_size) do |prime|
            primes_sieve[prime] = true
            primes_list << prime
        end
    else    
        Prime.each(list_size) do |prime|
            primes_sieve[prime] = true
            primes_list << prime if prime > prime_minimum
        end
    end
    return primes_list, primes_sieve
end

def problem1
    x = 0
    (1...1000).each {|y| x += y if (y % 3 == 0 || y % 5 == 0)}
    puts x
end

def problem2
    sum = 2
    fibonacci = [1, 2]
    while fibonacci.last <= 4000000 do
        fibonacci << fibonacci[-1] + fibonacci[-2]
        sum += fibonacci.last if (fibonacci.last % 2 == 0)
    end
    puts sum
end

def problem3(number_to_factor)
    largest_factor = 1
    current_guess = 2
    while current_guess <= number_to_factor do
        if (number_to_factor % current_guess == 0 && prime?(current_guess))
            largest_factor = current_guess
            number_to_factor /= largest_factor
        end
        current_guess += 1
    end
    puts largest_factor
end

def problem4
    largest_palindrome = 0
    product = []
    (100..999).each do |xx|
        (xx..999).each do |yy|
            multiple = xx * yy
            if palindrome?(multiple.to_s)
                largest_palindrome = multiple if multiple > largest_palindrome
                product = [xx, yy]
            end
        end
    end
    p largest_palindrome
end

def problem5
    smallest_multiple = 20
    while true
        (1..20).each do |x|
            break if smallest_multiple % x != 0
            if x == 20
                puts smallest_multiple
                exit
            end
        end
        smallest_multiple += 20
    end
end

def problem6
    puts ((1..100).inject {|sum, x| sum + x} ** 2) - (1..100).inject {|sum, y| sum + (y * y)}
end

def problem7
    puts get_nth_prime(10001)
end

def problem8
    greatest_product = 0
    number_to_analyze = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
    (12..1000).each do |place_in_number|
        product_of_adjacent_numbers = 1
        (place_in_number-12..place_in_number).each do |adjacent_numbers|
            product_of_adjacent_numbers *= number_to_analyze[adjacent_numbers].to_i
        end
        greatest_product = product_of_adjacent_numbers if product_of_adjacent_numbers > greatest_product
    end
    puts greatest_product
end

def problem9
    c = 3
    while true do
        c += 1
        (1...c-1).each do |aa|
            (aa+1...c).each do |bb|
                if (aa*aa) + (bb*bb) == (c*c) && aa + bb + c == 1000 then
                    puts "with #{aa}, #{bb} and #{c}, we have #{aa*aa} + #{bb*bb} = #{c*c}"
                    puts "Product is #{aa*bb*c}"
                    exit
                end
            end
        end
    end
end

def problem10
    sum = 0
    (1..2000000).each {|num| sum += num if is_prime(num); p num if num%10000 == 0}
    puts sum
end

def problem11
    greatest_product = 0
    number_to_analyze = %w{08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48}.map {|num| num.to_i}.each_slice(20).to_a
    # left-right
    (0..19).each do |i|
        (0..15).each do |j|
            product = number_to_analyze[i][j] * number_to_analyze[i][j+1] * number_to_analyze[i][j+2] * number_to_analyze[i][j+3]
            greatest_product = product if product > greatest_product
        end
    end
    # up-down
    (0..15).each do |i|
        (0..19).each do |j|
            product = number_to_analyze[i][j] * number_to_analyze[i+1][j] * number_to_analyze[i+2][j] * number_to_analyze[i+3][j]
            greatest_product = product if product > greatest_product
        end
    end
    # diagonal left to right
    (0..15).each do |i|
        (0..15).each do |j|
            product = number_to_analyze[i][j] * number_to_analyze[i+1][j+1] * number_to_analyze[i+2][j+2] * number_to_analyze[i+3][j+3]
            greatest_product = product if product > greatest_product
        end
    end
    # diagonal right to left
    (0..15).each do |i|
        (0..15).each do |j|
            product = number_to_analyze[i+3][j] * number_to_analyze[i+2][j+1] * number_to_analyze[i+1][j+2] * number_to_analyze[i][j+3]
            greatest_product = product if product > greatest_product
        end
    end
    puts greatest_product
end

def problem12
    divisor_count = 0
    triangle_number = 0
    triangle_count = 0
    until divisor_count > 500 do
        triangle_count += 1
        triangle_number += triangle_count
        divisor_count = 1
        (1..(triangle_number/2)+1).each do |div|
            divisor_count += 1 if triangle_number % div == 0
        end
    end
    puts triangle_number
end

def problem13
    number_to_analyze = %w{37107287533902102798797998220837590246510135740250 46376937677490009712648124896970078050417018260538 74324986199524741059474233309513058123726617309629 91942213363574161572522430563301811072406154908250 23067588207539346171171980310421047513778063246676 89261670696623633820136378418383684178734361726757 28112879812849979408065481931592621691275889832738 44274228917432520321923589422876796487670272189318 47451445736001306439091167216856844588711603153276 70386486105843025439939619828917593665686757934951 62176457141856560629502157223196586755079324193331 64906352462741904929101432445813822663347944758178 92575867718337217661963751590579239728245598838407 58203565325359399008402633568948830189458628227828 80181199384826282014278194139940567587151170094390 35398664372827112653829987240784473053190104293586 86515506006295864861532075273371959191420517255829 71693888707715466499115593487603532921714970056938 54370070576826684624621495650076471787294438377604 53282654108756828443191190634694037855217779295145 36123272525000296071075082563815656710885258350721 45876576172410976447339110607218265236877223636045 17423706905851860660448207621209813287860733969412 81142660418086830619328460811191061556940512689692 51934325451728388641918047049293215058642563049483 62467221648435076201727918039944693004732956340691 15732444386908125794514089057706229429197107928209 55037687525678773091862540744969844508330393682126 18336384825330154686196124348767681297534375946515 80386287592878490201521685554828717201219257766954 78182833757993103614740356856449095527097864797581 16726320100436897842553539920931837441497806860984 48403098129077791799088218795327364475675590848030 87086987551392711854517078544161852424320693150332 59959406895756536782107074926966537676326235447210 69793950679652694742597709739166693763042633987085 41052684708299085211399427365734116182760315001271 65378607361501080857009149939512557028198746004375 35829035317434717326932123578154982629742552737307 94953759765105305946966067683156574377167401875275 88902802571733229619176668713819931811048770190271 25267680276078003013678680992525463401061632866526 36270218540497705585629946580636237993140746255962 24074486908231174977792365466257246923322810917141 91430288197103288597806669760892938638285025333403 34413065578016127815921815005561868836468420090470 23053081172816430487623791969842487255036638784583 11487696932154902810424020138335124462181441773470 63783299490636259666498587618221225225512486764533 67720186971698544312419572409913959008952310058822 95548255300263520781532296796249481641953868218774 76085327132285723110424803456124867697064507995236 37774242535411291684276865538926205024910326572967 23701913275725675285653248258265463092207058596522 29798860272258331913126375147341994889534765745501 18495701454879288984856827726077713721403798879715 38298203783031473527721580348144513491373226651381 34829543829199918180278916522431027392251122869539 40957953066405232632538044100059654939159879593635 29746152185502371307642255121183693803580388584903 41698116222072977186158236678424689157993532961922 62467957194401269043877107275048102390895523597457 23189706772547915061505504953922979530901129967519 86188088225875314529584099251203829009407770775672 11306739708304724483816533873502340845647058077308 82959174767140363198008187129011875491310547126581 97623331044818386269515456334926366572897563400500 42846280183517070527831839425882145521227251250327 55121603546981200581762165212827652751691296897789 32238195734329339946437501907836945765883352399886 75506164965184775180738168837861091527357929701337 62177842752192623401942399639168044983993173312731 32924185707147349566916674687634660915035914677504 99518671430235219628894890102423325116913619626622 73267460800591547471830798392868535206946944540724 76841822524674417161514036427982273348055556214818 97142617910342598647204516893989422179826088076852 87783646182799346313767754307809363333018982642090 10848802521674670883215120185883543223812876952786 71329612474782464538636993009049310363619763878039 62184073572399794223406235393808339651327408011116 66627891981488087797941876876144230030984490851411 60661826293682836764744779239180335110989069790714 85786944089552990653640447425576083659976645795096 66024396409905389607120198219976047599490197230297 64913982680032973156037120041377903785566085089252 16730939319872750275468906903707539413042652315011 94809377245048795150954100921645863754710598436791 78639167021187492431995700641917969777599028300699 15368713711936614952811305876380278410754449733078 40789923115535562561142322423255033685442488917353 44889911501440648020369068063960672322193204149535 41503128880339536053299340368006977710650566631954 81234880673210146739058568557934581403627822703280 82616570773948327592232845941706525094512325230608 22918802058777319719839450180888072429661980811197 77158542502016545090413245809786882778948721859617 72107838435069186155435662884062257473692284509516 20849603980134001723930671666823555245252804609722 53503534226472524250874054075591789781264330331690}.map {|num| num.to_i}
    sum = number_to_analyze.inject(0) {|sums, num| sums += num}
    puts sum.to_s[0..9]
end

def problem14
    largest_number_and_chain = [0, 0]
    (1...1000000).each do |iteration|
        num = iteration
        chain = 1
        until num == 1 do
            if num % 2 == 0 then num = num / 2
            else num = (3 * num) + 1
            end
            chain += 1
        end
        largest_number_and_chain = [iteration, chain] if largest_number_and_chain[1] < chain
    end
    p largest_number_and_chain
end

# @path_count = 0
# def problem15 current_point_in_path
#     if current_point_in_path == [19, 19]
#         @path_count += 1
#     elsif current_point_in_path[0] < 19 && current_point_in_path[1] < 19
#         problem15([current_point_in_path[0] + 1, current_point_in_path[1]])
#         problem15([current_point_in_path[0], current_point_in_path[1] + 1])
#     elsif current_point_in_path[0] < 19
#         problem15([current_point_in_path[0] + 1, current_point_in_path[1]])
#     elsif current_point_in_path[1] < 19
#         problem15([current_point_in_path[0], current_point_in_path[1] + 1])
#     end
# end

def problem15
    path_counter = Array.new(21) {Array.new(21)}
    (0..20).each do |i|
        (0..20).each do |j|
            path_counter[i][j] = (i == 0 || j == 0) ? 1 : path_counter[i][j-1] + path_counter[i-1][j]
            
        end
    end
    path_counter.each {|i| p i}
end


def problem16
    sum = 0
    (2 ** 1000).to_s.each_char {|char| sum += char.to_i}
    p sum
end

def problem17
    letters_in_total = 0
    (1..1000).each do |number|
        letters_in_total += integer_to_word_string(number).gsub(" ","").length
    end
    puts letters_in_total
end

@numbers_triangle = [%w{75},%w{95 64},%w{17 47 82},%w{18 35 87 10},%w{20 04 82 47 65},%w{19 01 23 75 03 34},%w{88 02 77 73 07 63 67},%w{99 65 04 28 06 16 70 92},%w{41 41 26 56 83 40 80 70 33},%w{41 48 72 33 47 32 37 16 94 29},%w{53 71 44 65 25 43 91 52 97 51 14},%w{70 11 33 28 77 73 17 78 39 68 17 57},%w{91 71 52 38 17 14 91 43 58 50 27 29 48},%w{63 66 04 68 89 53 67 30 73 16 69 87 40 31},%w{04 62 98 27 23 09 70 98 73 93 38 53 60 04 23}]
@max_sum = 0
def problem18(i, j, path_sum)
    if i == @numbers_triangle.size - 1 then
        path_sum += @numbers_triangle[i][j].to_i
        @max_sum = path_sum if path_sum > @max_sum
    else
        problem18(i+1, j, path_sum + @numbers_triangle[i][j].to_i)
        problem18(i+1, j+1, path_sum + @numbers_triangle[i][j].to_i)
    end
    # puts @max_sum
end

def problem19
    sunday_count = 0
    total_day_count = 2
    (1901..2000).each do |year|
        total_day_count += 31 # January
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += year % 4 == 0 ? 29 : 28 # February, accounts for leap years
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 31 # March
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 30 # April
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 31 # May
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 30 # June
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 31 # July
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 31 # August
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 30 # September
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 31 # October
        sunday_count += 1 if total_day_count % 7 == 0
        total_day_count += 30 # November
        sunday_count += 1 if total_day_count % 7 == 0
        unless year == 2000
            total_day_count += 31 # December
            sunday_count += 1 if total_day_count % 7 == 0
        end
    end
    puts sunday_count
end

def problem20
    factorial(100).to_s.chars.inject(0) {|sum, char| sum += char.to_i}
end

def problem21
    amicable_numbers = []
    (2...10000).each do |number_to_test|
        sum1 = factors(number_to_test, true).sum
        sum2 = factors(sum1, true).sum
        if sum1 != sum2 && sum2 == number_to_test
            amicable_numbers << number_to_test << sum1
            p amicable_numbers
        end
    end
end

def problem22
    name_scores = []
    list_of_names = File.open("p022_names.txt").readlines[0].split("\",\"")
    list_of_names[-1].slice!(/\"/)
    list_of_names[0].slice!(/\"/)
    list_of_names.sort!
    list_of_names.each_with_index {|name, index| name_scores << (alphabetical_word_value(name) * (index + 1))}
    puts name_scores.sum
end

def problem23
    puts "Finding abundant numbers"
    abundant_numbers = (1..28123).select {|num| factors(num, true).sum > num}
    puts "Testing for non-sums"
    not_sum_of_two_abundant = []
    (1..28123).each do |num_to_test|
        puts num_to_test if num_to_test % 1000 == 0
        abundant_numbers.each_with_index do |num1, index1|
            break if num1 >= num_to_test || not_sum_of_two_abundant[-1] == false
            abundant_numbers[index1..-1].each do |num2| 
              break if num1 + num2 > num_to_test
              if num1 + num2 == num_to_test
                not_sum_of_two_abundant << false
                break
              end
            end
        end
  not_sum_of_two_abundant << num_to_test if not_sum_of_two_abundant[-1] != false
  not_sum_of_two_abundant.pop if not_sum_of_two_abundant[-1] == false
    end
puts not_sum_of_two_abundant.sum
end

def problem24
    p [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].permutation.to_a[999999]
end

def problem25
  (10..Float::INFINITY).each do |nth|
    current_place_in_sequence = nth_fibnoacci(nth)
    if current_place_in_sequence.to_s.length >= 1000
      return current_place_in_sequence 
    end
  end
end

def repeating_cycle(number_to_test)
    return 0 if number_to_test % 2 == 0 or number_to_test % 5 == 0
    (1..Float::INFINITY).each do |num|
        return num if ((10 ** num) - 1) % number_to_test == 0
    end
end

def problem26
    longest_repetition = {number: 0, length: 0}
    (1..999).each do |test_if_cycles|
        next unless prime?(test_if_cycles)
        length_of_cycle = repeating_cycle(test_if_cycles)
        longest_repetition = {number: test_if_cycles, length: length_of_cycle} if length_of_cycle > longest_repetition[:length]
    end
    p longest_repetition
    
    # holder1 = (1..999).collect {|num| [num, ((10 ** 2000) / num)]}
    # holder1 = holder1.collect {|num| [num[0], num[1].to_s] if num[1].to_s.chars.uniq.size > 2}.compact
    # holder1 = holder1.collect {|num| holder2 = num[1].match(/(.+)\1/); [num[0], holder2[1]] unless holder2.nil?}.compact
    # holder1 = holder1.collect {|num| [num[0], num[1].to_s] if num[1].to_s.chars.uniq.size > 2}.compact
    # holder1 = holder1.collect do |num|
    #     holder2 = num
    #     while true do
    #         break if holder2[1].match(/(.+)\1/).nil?
    #         holder2 = [holder2[0], holder2[1].match(/(.+)\1/)[1]]
    #     end
    #     holder2
    # end
    # holder1.each {|num| longest_repetition = {number: num[0], length: num[1].length} if num[1].length > longest_repetition[:length]}
    # p longest_repetition
end

def problem27
    max_consecutive_primes = {a: nil, b: nil, consec: 0}
    (-999..999).each do |a|
        (-999..999).each do |b|
            (0..Float::INFINITY).each do |n|
                unless prime?((n * n) + (a * n) + b)
                    max_consecutive_primes = {a: a, b: b, consec: n} if n > max_consecutive_primes[:consec]
                    break
                end
            end
        end
    end
    p "Finished with #{max_consecutive_primes } and a product of #{(max_consecutive_primes[:a] * max_consecutive_primes[:b]).to_s}"
end

def problem28
    matrix_size = 1001
    spiral = SpiralArray.new(matrix_size, clockwise: false)
    spiral.diagonals.sum
end


def problem29
    (2..100).collect do |a|
        (2..100).collect do |b|
            BigDecimal.new("#{a**b}")
        end
    end.flatten.uniq.size
end

def problem30
    (2..1000000).select do |num|
        num.to_s.chars.inject(0) {|sum, n| sum + (n.to_i)**5} == num
    end.sum
end

def problem31
    counter = 0
    (0..200).each do |a|
        puts "Currently on #{a}"
        (0..100).each do |b|
            (0..40).each do |c|
                (0..20).each do |d|
                    (0..10).each do |e|
                        (0..4).each do |f|
                            (0..2).each do |g|
                                (0..1).each do |h|
                                    counter += 1 if a + (2*b) + (5*c) + (10*d) + (20*e) + (50*f) + (100*g) + (200*h) == 200
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    counter
end

def problem32
    pandigital = []
    (1..10000).each do |num1|
        (1..10000).each do |num2|
            product = num1 * num2
            break if (num1.to_s + num2.to_s + product.to_s).length > 9
            pandigital << product if (num1.to_s + num2.to_s + product.to_s).chars.delete_if {|char| char == "0"}.uniq.size == 9
        end
    end
    p pandigital.uniq.sum
end

def problem33
    numerators, denominators = [], []
    (11..99).each do |numerator|
        (11..99).each do |denominator|
            next if numerator >= denominator
            next if (numerator % 10 == 0) && (denominator % 10 == 0)
            next if (numerator.to_s + denominator.to_s).chars.uniq.size != 3 || numerator.to_s.chars.uniq.size != 2 || denominator.to_s.chars.uniq.size != 2
                # Find which digit is the one which repeats, and thus you need to delete for testing. #
            repeating_char = Hash.new(0)
            (numerator.to_s + denominator.to_s).chars.each {|char| repeating_char[char] += 1}
            repeating_single_char = repeating_char.key(repeating_char.values.max)
            
            if BigDecimal.new(numerator.to_s) / BigDecimal.new(denominator.to_s) == BigDecimal.new(numerator.to_s.delete!(repeating_single_char)) / BigDecimal.new(denominator.to_s.delete!(repeating_single_char))
                numerators << numerator
                denominators << denominator
            end
        end
    end
        # Need to switch denominator and numerator in order to find the proper answer to the question.
    p denominators.inject(1) {|product, fraction| product *= fraction} / numerators.inject(1) {|product, fraction| product *= fraction}
end

def problem34
    (3..100000).select {|num| num.to_s.chars.inject(0) {|sum, char| sum += factorial(char.to_i)} == num}.sum
end

def problem35
    circular_primes = (1..999999).select do |might_be_circular|
        p might_be_circular if might_be_circular % 50000 == 0
        (1..might_be_circular.to_s.length).all? do |rot|
            prime?(might_be_circular.to_s.chars.rotate(rot).join("").to_i)
        end
    end.uniq
    circular_primes.count
end

def problem36
    (1..999999).step(2).select do |possibly_palindromic|
        palindrome?(possibly_palindromic.to_s) && palindrome?(to_binary(possibly_palindromic))
    end.sum
end

def problem37
    (10..1000000).select do |num|
        p num if num % 100000 == 0
        false unless prime?(num)
        (0..num.to_s.length - 1).all? {|trunc| prime?(num.to_s[trunc..-1].to_i)} &&
        (0..num.to_s.length - 1).all? {|trunc| prime?(num.to_s[0..-1 - trunc].to_i)}
    end.sum
end

def problem38
    pandigital = 0
    (1..10000).each do |num|
        possible_pandigital = ""
        (1..10).each do |n|
            break if possible_pandigital.length > 9 || possible_pandigital.include?("0")
            possible_pandigital += (num * n).to_s
            if possible_pandigital.length == 9
                break if possible_pandigital.chars.uniq.size < 9
                pandigital = possible_pandigital.to_i if possible_pandigital.to_i > pandigital
            end
        end
    end
    pandigital
end

def problem39
    start = Time.now
    most_solutions = {perimeter: nil, solutions: 0}
    (3..1000).each do |p|
        triangles = []
        (1..p-1).each do |b|
            p = p.to_f
            c = ((p*p) - (2*p*b) + (2*b*b)) / (2*(p - b))
            a = p - b - c
            next unless c > 0 && a > 0 && c % 1.0 == 0.0
            triangles << [a.to_i, b, c.to_i]
        end
        solutions = triangles.collect {|triangle| triangle.sort}.uniq.size
        most_solutions = {perimeter: p.to_i, solutions: solutions} if solutions > most_solutions[:solutions]
    end
    p most_solutions
    p Time.now - start
end

def problem40
    # Solved entirely in Excel.
end

def problem41
    pandigital = "123456789"
    while true do
        perms = pandigital.chars.permutation.to_a.select {|perm| Prime::prime?(perm.join("").to_i)}
        if perms.size == 0
            pandigital.slice!(-1)
            next
        end
        perms = perms.collect {|perm| perm.join("").to_i}
    break
    end
    perms.max
end

def problem42
    triangle_numbers = (1..50).collect {|num| (0.5 * num * (num + 1)).to_i}
    list_of_words = CSV.read("p042_words.txt")[0]
    triangle_words = list_of_words.select do |word|
        word_value = word.chars.inject(0) {|value, char| value + char.ord - 64}
        triangle_numbers.include?(word_value)
    end
    triangle_words.size
end

def problem43
    pandigital = "0123456789"
    perms = pandigital.chars.permutation.to_a.select do |perm|
        perm[3].to_i.even? &&
        perm[2..4].to_i % 3 == 0 &&
        (perm[5] == "0" || perm[5] == "5") &&
        perm[4..6].to_i % 7 == 0 &&
        perm[5..7].to_i % 11 == 0 &&
        perm[6..8].to_i % 13 == 0 &&
        perm[7..9].to_i % 17 == 0
    end
    p perms = perms.collect {|perm| perm.join("").to_i}
    p perms.sum
end

def problem44
    pentagonal_numbers = (1..10000).collect {|num| (num * ((3 * num) - 1) / 2)}
  pentagonal_numbers[1..-1].each_with_index do |pent1, i|
    pentagonal_numbers[0..i].each do |pent2|
    sum, difference = pent1 + pent2, pent1 - pent2
      if pentagonal?(sum) && pentagonal?(difference)
                return difference
      end
    end
  end
end

# def problem45
#     (40756..Float::INFINITY).each do |num|
#         hex = to_hexagonal(num)
#         return to_triangular(num) if triangular?(hex) && pentagonal?(hex)
#     end
# end
def problem45
    (40756..Float::INFINITY).each do |num|
        tri = to_triangular(num)
        return tri if hexagonal?(tri) && pentagonal?(tri)
    end
end

def problem46
    primes = Array.new(10000)
    Prime.each do |prime|
        break if prime > 10000
        primes[prime] = true
    end
    additives = Array.new(10000)
    
    
    (3..Float::INFINITY).step(2).each do |composite|
        next if primes[composite]
        Prime.each do |prime|
          return composite if (prime >= composite - 1)
          goldbach = false
          (1..(Math::sqrt(composite))).each do |square|
              goldbach = (composite == prime + (2 * (square**2)))
              break if goldbach
          end
          break if goldbach
        end
    end
end

# def problem47
#     primes = Array.new(1000)
#     Prime.each do |prime|
#         break if prime > 1000
#         primes[prime] = true
#     end
    
#     (10..Float::INFINITY).each do |num|
#         (0..3).each do |count|
#             factors = factors(num + count)
#             num_of_primes = 0
#             factors.each do |fact|
#                 num_of_primes += 1 if primes[fact]
#                 break if num_of_primes == 4
#             end
#             break unless num_of_primes == 4
#             return [num, num+1, num+2, num+3] if count == 3
#         end
#     end
# end

def problem47
    (1..Float::INFINITY).each do |num|
        (0..3).each do |count|
            prime_factors = Prime.prime_division(num + count).size
            break unless prime_factors >= 4
            return num if count == 3
        end
    end
end

def problem48
    (1..1000).inject(0) {|total, num| total += num**num % 10000000000} % 10000000000
end

def problem49
    primes_list, primes_sieve = create_primes_list_and_sieve(10000, 1000)
    
    sequences = []
    primes_list.each_with_index do |prime1|
        prime_permutations = prime1.to_s.chars.permutation.to_a.select {|perm| primes_sieve[perm.join.to_i]}.collect {|perm| perm.join.to_i}.uniq.sort
        next unless prime_permutations.size > 2
        prime_permutations.each_with_index do |prime_perm1, index|
            prime_permutations[index + 1..-1].each do |prime_perm2|
                difference = prime_perm2 - prime_perm1
                sequences << [prime_perm1, prime_perm2, prime_perm2 + difference] if prime_permutations.include?(prime_perm2 + difference)
            end
        end
    end
    sequences.uniq
end

def problem50
    primes_list, primes_sieve = create_primes_list_and_sieve(1000000)
    
    consecutives = {prime: nil, length: 0}
    primes_list.each_with_index do |prime1, index|
        sum, length = prime1, 1
        primes_list[index + 1..-1].each do |prime2|
            break if sum >= 1000000
            sum += prime2
            length += 1
            next unless length > 500
            consecutives = {prime: sum, length: length} if primes_sieve[sum] && length > consecutives[:length]
        end
    end
    consecutives
end

def problem51
    primes_list, primes_sieve = create_primes_list_and_sieve(10000000, 50000)

  primes_list.each do |prime|
        family_count = [0, []]
    (1..prime.to_s.length - 1).each do |num_of_replacements|
      replacement_pattern = ""
      num_of_replacements.times {replacement_pattern << "x"}
      replacement_strings = replacement_pattern.rjust(prime.to_s.length, "y").chars.permutation
      replacement_strings.each do |perm|
        (0..9).each do |replacement_digit|
          next unless family_count[0] > replacement_digit - 3
              prime_digits = prime.to_s.chars
          perm.each_with_index {|char, index| prime_digits[index] = replacement_digit.to_s if char == "x"}
            next if prime_digits[0] == "0"
          if primes_sieve[prime_digits.join.to_i]
            family_count[0] += 1
            family_count[1] << prime_digits.join.to_i
          end
        end
        if family_count[0] >= 8
          return family_count 
        else family_count = [0, []]
        end
      end
    end
  end
end

def problem52
    start, finish = 1, 10
    while true
        (start..finish).each do |num|
            break if (num * 6) >= finish
            (2..6).each do |mult|
                break unless num.to_s.chars.sort == (num * mult).to_s.chars.sort
                return num if mult == 6
            end
        end
    start, finish = finish + 1, finish * 10
    end
end

def problem53
    fact = [1] # Factorial of 0 is 1.
    (1..100).each {|num| fact << num * fact[-1]}
    # (1..100).inject(1) {|a,b| c = a*b; fact << c; c}
  big_comb_count = 0
  (23..100).each do |n|
    (1..n - 1).each do |r|
      comb = fact[n] / (fact[r] * fact[n - r])
      break if r > n / 2 && comb < 1000000
      big_comb_count += 1 if comb >= 1000000
    end
  end
  big_comb_count
end

def determine_hand_rank(hand)
    hand_values = hand.collect {|card| card[0].sub(/[TJQKA]/, 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14).to_i}
    hand_values_sorted = hand_values.sort
    hand_values_count = Hash.new(0)
    hand_values.each {|value| hand_values_count[value] += 1}
    hand_suits = hand.collect {|card| card[1]}
    if hand_values_sorted == [10, 11, 12, 13, 14] && hand_suits.uniq.size == 1
      return [10]
    elsif hand_suits.uniq.size == 1 && [hand_values_sorted[0], hand_values_sorted[0] + 1, hand_values_sorted[0] + 2, hand_values_sorted[0] + 3, hand_values_sorted[0] + 4] == hand_values_sorted
      return [9, hand_values_sorted[4]]
    elsif hand_values_count.values.include?(4)
      return [8, hand_values_count.key(hand_values_count.values.max)]
    elsif hand_values.uniq.size == 2 && hand_values_count.values.include?(4)
      return [7, hand_values_count.key(3)]
    elsif hand_suits.uniq.size == 1
      return [6, hand_values.max]
    elsif [hand_values_sorted[0], hand_values_sorted[0] + 1, hand_values_sorted[0] + 2, hand_values_sorted[0] + 3, hand_values_sorted[0] + 4] == hand_values_sorted
      return [5, hand_values.max]
    elsif hand_values_count.values.include?(3)
      return [4, hand_values_count.key(hand_values_count.values.max)]
    elsif hand_values.uniq.size == 3
      highest_values = [hand_values_count.select{|card, count| count > 1}.keys, hand_values_count.key(1)].flatten
      return [3] + highest_values
    elsif hand_values.uniq.size == 4
      highest_values = [hand_values_count.key(2), hand_values_count.select{|card, count| count == 1}.keys.sort.reverse].flatten
      return [2] + highest_values
    elsif hand_values.uniq.size == 5
      return [1] + hand_values_sorted.reverse
    else 
        p "Found nil, with hand #{hand}"
        return nil
    end
end

def determine_hand_winner(hand1_rank, hand2_rank)
    if hand1_rank[0] > hand2_rank[0] then return 1
    elsif hand2_rank[0] > hand1_rank[0] then return 0
    elsif hand1_rank[1] > hand2_rank[1] then return 1
    elsif hand2_rank[1] > hand1_rank[1] then return 0
    elsif hand1_rank[2] > hand2_rank[2] then return 1
    elsif hand2_rank[2] > hand1_rank[2] then return 0
    elsif hand1_rank[3] > hand2_rank[3] then return 1
    elsif hand2_rank[3] > hand1_rank[3] then return 0
    elsif hand1_rank[4] > hand2_rank[4] then return 1
    elsif hand2_rank[4] > hand1_rank[4] then return 0
    else
        puts "Can't determine winner, with hands #{hand1_rank} and #{hand2_rank}"
        return nil
    end
end

def problem54
    start = Time.now
    player1_hands, player2_hands, player1_scores, player2_scores = [], [], 0, 0
    IO.foreach("p054_poker.txt") do |line|
        line.chomp!
        both_hands = line.split
        player1_hands << both_hands[0..4]
        player2_hands << both_hands[5..9]
    end
    (0..player1_hands.size - 1).each do |hand_number|
        player1_hand_rank = determine_hand_rank(player1_hands[hand_number])
        player2_hand_rank = determine_hand_rank(player2_hands[hand_number])
        determine_hand_winner(player1_hand_rank, player2_hand_rank) == 0 ? player1_scores += 1 : player2_scores += 1
    end
    puts "Player1 won #{player1_scores}, and player2 won #{player2_scores}."
    puts Time.now - start
end

def problem55
    list_of_lychrel_numbers = []
    (1..9999).each do |lychrel|
        possible_palindrome = lychrel
        (1..50).each do |iteration|
            possible_palindrome = possible_palindrome + possible_palindrome.to_s.reverse.to_i
            break if possible_palindrome.to_s == possible_palindrome.to_s.reverse
            list_of_lychrel_numbers << lychrel if iteration == 50
        end
    end
    list_of_lychrel_numbers.size
end

def problem56
    maximum_digital_sum = 0
    (1..100).each do |a|
        (1..100).each do |b|
            digital_sum = (a**b).to_s.chars.inject(0) {|sum, digit| sum += digit.to_i}
            maximum_digital_sum = digital_sum if digital_sum > maximum_digital_sum
        end
    end
    p maximum_digital_sum
end

def problem57
    numer, denom = 3, 2
    (2..1000).select do |i|
        denom += numer
        numer = (2 * denom) - numer
        numer.to_s.length > denom.to_s.length
    end.size
end

def problem58
    (2501..Float::INFINITY).step(2).each do |side_length|
        diagonals = SpiralArray.new(side_length.to_i, clockwise: false).diagonals
        p "#{side_length} and #{(diagonals.select {|num| prime?(num)}.size / ((2 * side_length) - 1)) * 100}" if (side_length - 1) % 100 == 0
        # p diagonals
        # p diagonals.select {|num| prime?(num)}.size
        # p (diagonals.select {|num| prime?(num)}.size / ((2 * side_length) - 1)) * 100
        return side_length.to_i if (diagonals.select {|num| prime?(num)}.size / ((2 * side_length) - 1)) * 100 < 10
    end
end

def problem58
    diagonal_primes = [3, 5, 7]
    (5..Float::INFINITY).step(2).each do |side_length|
    side_length = side_length
        diag1 = 4 * ((2..side_length - 3).step(2).inject(:+)) + side_length
        diagonals = [diag1, diag1 + side_length - 1, diag1 + 2 * (side_length - 1), diag1 + 3 * (side_length - 1)]
        diagonal_primes += diagonals.select {|diag| prime?(diag)}
    return side_length.to_i if (diagonal_primes.size / ((2 * side_length) - 1)) * 100 < 10
    end
end

def problem59
    cipher = CSV.read("#{ENV["HOME"]}/workspace/euler_problems/p059_cipher.txt")[0]
    decrypted = File.new("#{ENV["HOME"]}/workspace/euler_problems/decrypted.txt", "w")
    (97..122).each do |a|
        (97..122).each do |b|
            (97..122).each do |c|
    
                # This is the frequency analysis.
                # decrypt = [[],[],[]]
                # cipher.each_with_index do |char, index|
                #     if index % 3 == 0
                #         decrypt[0] << (char.to_i ^ 32).chr
                #     elsif index % 3 == 1
                #         decrypt[1] << (char.to_i ^ 32).chr
                #     elsif index % 3 == 2
                #         decrypt[2] << (char.to_i ^ 32).chr
                #     end
                # end
                # (0..2).each do |index|
                #     holder = Hash.new(0)
                #     decrypt[index].each {|char| holder[char] += 1}
                #     p "index #{index} is #{holder.key(holder.values.max)}"
                # end
                
                # This is once you find the proper key, for the purpose of summing.
                # a, b, c = 103, 111, 100
                # decrypt = cipher[0..50].collect.with_index do |char, index|
                #     if index % 3 == 0
                #         (char.to_i ^ a).chr
                #     elsif index % 3 == 1
                #         (char.to_i ^ b).chr
                #     elsif index % 3 == 2
                #         (char.to_i ^ c).chr
                #     end
                # end.join
                # decrypt.chars.inject(0) {|sum, char| sum += char.ord}
                
                decrypt = cipher[0..100].collect.with_index do |char, index|
                    if index % 3 == 0
                        (char.to_i ^ a).chr
                    elsif index % 3 == 1
                        (char.to_i ^ b).chr
                    elsif index % 3 == 2
                        (char.to_i ^ c).chr
                    end
                end.join
                decrypted.write(decrypt + "    [#{a}, #{b}, #{c}]\n")
            end
        end
    end
end

def problem60
    primes_list = Prime.each(10000).collect {|prime| prime}
    
    sets_of_primes, lowest_sum = [], 0
    primes_list.each_with_index do |prime1, index1|
    break if lowest_sum != 0 && (prime1 * 5) + 10 > lowest_sum
        primes_list[index1 + 1..-1].each_with_index do |prime2, index2|
      break if lowest_sum != 0 && prime1 + (prime2 * 4) + 6 > lowest_sum
            next unless prime_in_both_directions(prime1, prime2)
            primes_list[index1 + index2 + 2..-1].each_with_index do |prime3, index3|
        break if lowest_sum != 0 && prime1 + prime2 + (prime3 * 3) + 3 > lowest_sum
                next unless prime_in_both_directions(prime1, prime3) && prime_in_both_directions(prime2, prime3)
                primes_list[index1 + index2 + index3 + 3..-1].each_with_index do |prime4, index4|
          break if lowest_sum != 0 && prime1 + prime2 + prime3 + (prime4 * 2) + 1 > lowest_sum
                    next unless prime_in_both_directions(prime1, prime4) && prime_in_both_directions(prime2, prime4) && prime_in_both_directions(prime3, prime4)
                    primes_list[index1 + index2 + index3 + index4 + 4..-1].each do |prime5|
            break if lowest_sum != 0 && prime1 + prime2 + prime3 + prime4 + prime5 > lowest_sum
                        next unless prime_in_both_directions(prime1, prime5) && prime_in_both_directions(prime2, prime5) &&
            prime_in_both_directions(prime3, prime5) && prime_in_both_directions(prime4, prime5)
                        if lowest_sum == 0 || prime1 + prime2 + prime3 + prime4 + prime5 < lowest_sum
              sets_of_primes = [prime1, prime2, prime3, prime4, prime5]
              lowest_sum = prime1 + prime2 + prime3 + prime4 + prime5
            end
                    end
                end
            end
        end
    end
    p sets_of_primes
  p lowest_sum
end

# @primes_sieve = Array.new(100000000)
# Prime.each(100000000) {|prime| @primes_sieve[prime] = true}

def prime_in_both_directions(prime1, prime2)
    return true if @primes_sieve[(prime1.to_s + prime2.to_s).to_i] && @primes_sieve[(prime2.to_s + prime1.to_s).to_i]
    return false
end

def problem61
    trinums, squarenums, pentnums, hexnums, heptnums, octnums = [], [], [], [], [], []
    [[trinums, method(:to_triangular)], [squarenums, :to_square], [pentnums, method(:to_pentagonal)], 
    [hexnums, method(:to_hexagonal)], [heptnums, method(:to_heptagonal)], [octnums, method(:to_octagonal)]].each do |nums, mthd|
        (1..Float::INFINITY).each do |num|
            x = mthd == :to_square ? (num * num) : mthd.call(num)
            break if x >= 10000
            nums << x if x >= 1000
        end
    end
    
    number_sets = [trinums, squarenums, pentnums, hexnums, heptnums, octnums]
    
    number_sets.each do |set1|; set1.each do |item1|
        number_sets.exclude(set1).each do |set2|; set2.each do |item2|
            if is_cyclical_with(item1, item2)
                number_sets.exclude(set1, set2).each do |set3|; set3.each do |item3|
                    if is_cyclical_with(item2, item3)
                        number_sets.exclude(set1, set2, set3).each do |set4|; set4.each do |item4|
                            if is_cyclical_with(item3, item4)
                                number_sets.exclude(set1, set2, set3, set4).each do |set5|; set5.each do |item5|
                                    if is_cyclical_with(item4, item5)
                                        number_sets.exclude(set1, set2, set3, set4, set5).each do |set6|; set6.each do |item6|
                                            if is_cyclical_with(item5, item6) && is_cyclical_with(item6, item1)
                                                set = [item1, item2, item3, item4, item5, item6]
                                                return [set, set.sum]
                                            end
                                        end; end
                                    end
                                end; end
                            end
                        end; end
                    end
                end; end
            end
        end; end
    end; end
end

def is_cyclical_with(num1, num2)
    return true if num1.to_s[2..3] == num2.to_s[0..1]
    return false
end


# Takes way too long, and requires arrays which are too big to fit in memory for the sieve

# def problem62
#     puts "Creating array of cubes."
#     cubes = Array.new(100000000)
#     (1..Float::INFINITY).each do |cube|
#         actual_cube = cube ** 3
#         break if actual_cube > 100000000
#         cubes[actual_cube] = true
#     end
    
#     puts "Testing permutations now."
#     (1..Float::INFINITY).each do |cube|
#         puts "At #{cube}" if cube % 10 == 0
#         list_of_cubes = (cube ** 3).to_s.chars.permutation.to_a.select do |perm|
#           possible_cube = perm.join("")
#           possible_cube[0] != "0" && cubes[possible_cube.to_i]
#         end
#         return cube if list_of_cubes.size > 4
#     end
# end

def problem62
  sorted_cubes, sorted_cubes_and_values = [], Hash.new([])
  (1..10000).each do |cube|
    sorted_cubes << (cube ** 3).to_s.chars.sort.join("")
    sorted_cubes_and_values[sorted_cubes[-1]] += [cube]
  end
  sorted_cubes_and_values.select {|sorted_cube, count| count.size > 4}.values.flatten.min ** 3
end

def problem63
    count = 0
    (1..9).each do |n|
        (1..Float::INFINITY).each do |i|
            break if ((n ** i).to_s.length - i) < 0
            count += 1
        end
    end
    count
end

# This cannot circumvent the issue of floating point precision.

# def problem64
#     periodicity = []
#     (1..10000).each do |num|
#         next if Math::sqrt(num) % 1 == 0
#         a0 = Math::sqrt(num).floor
#         a = (1 / (Math::sqrt(num) - a0))
#         periodicity << 1
#         while a.floor != (a0 * 2)
#             a = (1 / (a - a.floor))
#             periodicity[-1] += 1
#         end
#     end
#     periodicity.select {|period| period.odd?}.count
# end

def problem64
    periodicity = []
    (1..10000).each do |num|
        next if Math::sqrt(num) % 1 == 0
    periodicity << 0
        m, d, a = 0, 1, Math::sqrt(num).floor
        a0 = a
        while a != (a0 * 2)
      m = (d * a) - m
      d = ((num - (m ** 2)) / d)
            a = ((a0 + m) / d).floor
            periodicity[-1] += 1
        end
    end
    periodicity.select {|period| period.odd?}.count
end

def problem65
    numer0, numer1 = 2, 1
    (1..100).each do |iter|
        a = iter % 3 == 2 ? 2 * ((iter + 1)/ 3) : 1
        #     a = 2 * ((iter + 1)/ 3)
        # else a = 1
        # end
        numer2 = numer1
        numer1 = numer0
        numer0 = (a * numer1) + numer2
    end
    numer0.to_s.chars.inject(0) {|sum, char| sum += char.to_i}
end

def problem66
    x, final_D = 0, 0
    (1..1000).each do |bigD|
        next if Math::sqrt(bigD) % 1 == 0
        m, d, a = 0, 1, Math::sqrt(bigD).floor
        a0, numer0, numer1 = a, a, 1
        denom0, denom1 = 1, 0
        while (numer0*numer0 - bigD*denom0*denom0 != 1) do
            m = (d * a) - m
      d = ((bigD - (m ** 2)) / d)
            a = ((a0 + m) / d).floor
            numer2, denom2 = numer1, denom1
            numer1, denom1 = numer0, denom0
            numer0 = (a * numer1) + numer2
            denom0 = (a * denom1) + denom2
        end
        if numer0 > x
            x = numer0
            final_D = bigD
        end
    end
    final_D
end


def problem67
    triangle = []
    CSV.foreach("#{ENV["HOME"]}/workspace/euler_problems/p067_triangle.txt") do |row|
        triangle << row[0].split(" ").map(&:to_i)
    end
    
  (triangle.size - 2).downto(0) do |level|
    (0..triangle[level].size - 1).each do |item|
      triangle[level][item] += [triangle[level + 1][item], triangle[level + 1][item + 1]].max
    end
  end
  triangle[0][0]
end

def problem68
    sequence = []
    final_sequences = []
    (1..10).each do |num1|
        sequence << num1
        (1..10).exclude(sequence).each do |num2|
            sequence << num2
            (1..10).exclude(sequence).each do |num3|
                sequence << num3        # End of first triplet
                (1..10).exclude(sequence).each do |num4|
                    sequence << num4
                    sequence << sequence[-2]
                    (1..10).exclude(sequence).each do |num6|
                        next unless sequence[0..2].join.to_i == (sequence[3..4] + [num6]).join.to_i
                        sequence << num6        # End of second triplet
                        (1..10).exclude(sequence).each do |num7|
                            sequence << num7
                            sequence << sequence[-2]
                            (1..10).exclude(sequence).each do |num9|
                                next unless sequence[3..5].join.to_i == (sequence[6..7] + [num9]).join.to_i
                                sequence << num9       # End of third triplet
                                (1..10).exclude(sequence).each do |num10|
                                    sequence << num10
                                    sequence << sequence[-2]
                                    (1..10).exclude(sequence).each do |num12|
                                        next unless sequence[6..8].join.to_i == (sequence[9..10] + [num12]).to_i
                                        sequence << num12      # End of fourth triplet
                                        (1..10).exclude(sequence).each do |num13|
                                            sequence << num13
                                            sequence << sequence[-2]
                                            (1..10).exclude(sequence).each do |num15|
                                                next unless sequence[9..11].join.to_i == (sequence[12..13] + [num15]).join.to_i
                                                sequence << num15      # End of fifth and last triplet
                                                final_sequences << sequence
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    p final_sequences
    # final_sequences.collect do |seq|
    #     seq.scan(/.{3}/)
    # end
end

problem68
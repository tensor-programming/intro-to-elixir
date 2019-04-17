## Run Code in IEX (Interactive Elixir)

## Numbers - Integers and Floats

2 + 3
3 * 4
3 - 5
x = 10
## 5.0
x / 2

# 255
0xFF

3.14159

3.0e-2

div(5, 2)
rem(5, 2)

99_999_999_999_999_999_999_999_999_999_999_999_999_999_123_871_293_871_902_387_102 +
  99_999_999_999_999_999_999_999_999_999_999_999_999_999_123_871_293_871_902_387_102

## 1000000
1_000_000

## Atoms

:atoms

:"an atom"

:"12387 &*^#2"

var = :atom

## Aliases

AModule
# true
:"Elixir.AModule" == AModlue

alias IO, as: MyIO

MyIO.puts("Hello" == IO.puts("Hello"))

## Booleans and nil

true
false
true
false

# true
true == true
# true
false == false

true and false
true or false
not true

nil
nil
nil == nil

if 10 do
  IO.puts("true")
end

# prints true

if nil do
  IO.puts("true")
end

# get back nil

# short circuit
nil || false || 4 || true
true && 5
!5
nil && 5
true && 5 && nil && false

## Tuples

cat = {"Jazzpurr", 12}
age = elem(cat, 1)
put_elem(cat, 1, 13)
cat = put_elem(cat, 1, 23)

## Lists

numbers = [1, 2, 3, 4]
length(numbers)
Enum.at(numbers, 5)
Enum.at(numbers, 3)
3 in numbers
5 in numbers

List.replace_at(numbers, 0, 12)
# [12, 2, 3, 4]
List.insert_at(numbers, 3, 13)
List.insert_at(numbers, -1, 13)

[1, 2, 3] ++ [4, 5]
[head | tail] = [1, 2, 3, 4, 5, 6, 7]
# head = 1
# tail = [2, 3, 4, 5, 6, 7]

[1 | [2 | [3 | [4 | [5 | [6 | [7 | []]]]]]]]

hd(numbers)
tl(numbers)

alist = [15, :atom, true]
[:first | atlist]
# [:first, 15, :atom, true]

## Maps

empty = %{}
sqrs = %{1 => 1, 2 => 4, 3 => 9}

sqrs[1]
sqrs[2]

Map.get(sqrs, 3)
Map.get(sqrs, 5)

cat = %{name: "Jazzpurr", age: 12}
cat.age
cat.name
cat[:name]
cat[:age]

older_cat = %{cat | age: 15}
older_cat.age

## Binaries and Bitstrings
<<1, 2, 3>>
# <<0>>
<<256>>
# <<1>>
<<257>>
<<256::16>>
<<1::4, 15::4>>
<<1, 2>> <> <<3, 4>>

## Strings and Charlist
"This is a String"
"Add together #{3 + 4}"
"\r \n \" \\"

~s("This is a string!")
~S(This is a String!)

'ABC' == [65, 66, 67]
'sum: #{3 + 5}'
~c(Character Sigil)
# 'A String'
String.to_charlist("A String")

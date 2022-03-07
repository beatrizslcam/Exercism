defmodule PigLatin do
  @vowel ["a", "e", "i", "o", "u"]

  @spec translate(phrase :: String.t()) :: String.t()

  def translate(phrase) do
    words = String.split(phrase)
    pig_phrase = []
    take_word(pig_phrase, words)
  end

  defp take_word(pig_phrase, []) when is_list(pig_phrase), do: pig_phrase |> Enum.join(" ")
  defp take_word(pig_phrase, []), do: pig_phrase

  defp take_word(pig_phrase, words) do
    [head | tail] = words
    first_letter = String.at(head, 0)
    second_letter = String.at(head, 1)
    is_vowel = verify_vowel(first_letter)
    verifying(is_vowel, first_letter, second_letter, head, tail, pig_phrase)
  end

  defp verify_vowel(letter) do
      if Enum.member?(@vowel, letter) do :vowel
      else :consoant
    end
  end

  defp verifying(:consoant, "q", "u", head, tail, pig_phrase) do
    (pig_phrase ++ [String.replace(head, "qu", "") <> "qu" <> "ay"])
    |> take_word(tail)
  end

  defp verifying(:consoant, "x", second_letter, head, tail, pig_phrase) do
   if verify_vowel(second_letter) == :vowel  do
      pig_phrase ++ (String.replace(head, "x", "") <> "x" <> "ay")
    else
      (pig_phrase ++ [head <> "ay"])
      |> take_word(tail)
    end
  end

  defp verifying(:consoant, "y", second_letter, head, tail, pig_phrase) do
       if verify_vowel(second_letter) == :vowel do
      pig_phrase ++ (String.replace(head, "y", "") <> "y" <> "ay")
    else
      (pig_phrase ++ [head <> "ay"])
      |> take_word(tail)
    end
  end

  defp verifying(:consoant, first_letter, second_letter, head, tail, pig_phrase) do
      if verify_vowel(second_letter)== :vowel do
      switch(head, tail, pig_phrase, first_letter)
    else
      find(:consoant, head, 2, tail, pig_phrase)
    end
  end

  defp verifying(:vowel, _first_letter, _second_letter, head, tail, pig_phrase) do
    (pig_phrase ++ [head <> "ay"])
    |> take_word(tail)
  end

  defp switch(head, tail, pig_phrase, first_letter) do
    (pig_phrase ++ [String.replace(head, first_letter, "") <> first_letter <> "ay"])
    |> take_word(tail)
  end

  defp find(:consoant, head, acc, tail, pig_phrase) do
    String.at(head, acc)
    |> verify_vowel()
    |> find(head, acc + 1, tail, pig_phrase)
  end

  defp find(:vowel, head, acc, tail, pig_phrase) do
    (String.at(head, acc - 1) == "u" && String.at(head, acc - 2) == "q")
    |> final(head, acc, tail, pig_phrase)
  end

  defp final(true, head, acc, tail, pig_phrase) do
    {part2, part1} = String.split_at(head, acc)

    (pig_phrase ++ [part1 <> part2 <> "ay"])
    |> take_word(tail)
  end

  defp final(false, head, acc, tail, pig_phrase) do
    {part2, part1} = String.split_at(head, acc - 1)

    (pig_phrase ++ [part1 <> part2 <> "ay"])
    |> take_word(tail)
  end
end

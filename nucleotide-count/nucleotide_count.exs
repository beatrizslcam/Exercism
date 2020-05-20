 defmodule NucleotideCount do
	@nucleotides [?A, ?C, ?G, ?T]

	def count(strand, ?A) do
		Enum.filter(strand,&(&1 == ?A)) |> Enum.count()
		end

	def count(strand, ?C) do
		Enum.filter(strand,&(&1 == ?C)) |> Enum.count()
	end

	def count(strand, ?G) do
		Enum.filter(strand,&(&1 == ?G)) |> Enum.count()
	end

	def count(strand, ?T) do
		Enum.filter(strand,&(&1 == ?T)) |> Enum.count()
	end





	def histogram(strand) do

		a = NucleotideCount.count(strand, ?A)
		c =	NucleotideCount.count(strand, ?C)
		t =	NucleotideCount.count(strand, ?T)
		g =	NucleotideCount.count(strand, ?G)
		%{ ?A => a, ?C => c, ?G => g, ?T => t}
	end







end

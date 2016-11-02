---
title: Write Cucumber JVM Step Definitions
date: 2016-10-20 17:30:00 +0800
categories: [technology]
tags: [cucumber]
author: Kevin
---

[Original Link](http://blog.czeczotka.com/2014/08/17/writing-cucumber-jvm-step-definitions/)

When I started working with Cucumber JVM it took a while to get the knack of how to write nice and efficient step definitions. Being a regular expression ninja certainly helps but you can get by with a few examples which will enable you to write a wide range of Cucumber steps. Below are some I found the most useful.

## Exact match

I know it’s a no-brainer but will get you started.

	@Given("I have a cucumber step")
	public void i_have_a_cucumber_step() throws Throwable {
		System.out.println("Step definition exact match");
	}

## Use anchors

Remember to use anchors to mark the beginning (`^`) and end of the expression (`$`). The step definition above will match both steps below:

	Given I have a cucumber step
	Given I have a cucumber step and a salad

What we really want is to match the first one and get Cucumber to give us a stub implementation of the second one. In order to avoid unexpected matches we need to add anchors:

	@Given("^I have a cucumber step$")

## Capture integers and strings

	@Given("^I have (\\d+) (.*) in my basket$")
	public void i_have_in_my_basket(int number, String veg) throws Throwable {
		System.out.println(format("I have {0} {1} in my basket", number, veg));
	}
	
Let’s have a look at the step definition. By using round brackets we mark part of the expression as a capture group so that Cucumber can map it to a method parameter. In our case have the following patterns:

* \d+ matching at least one digit, d represents a digit, + is a quantifier and means one or more times; the expression is escaped with a backslash, because it also is the escape character in Java we need to escape it with another backslash and we end up with \\d+
* .+ matching at least one character, . (dot) represents any character

## Use non-capturing groups

It may be useful to have a bit of flexibility and add words in the step which are not matched. This is what non-capturing groups can be used for. There is a ?: operator (question mark and colon) and if it is present at the beginning of the group it will not be mapped to method parameters.

	@Given("^I have a (?:tasty|nasty|rusty) cucumber step$")
	public void i_have_a_X_cucumber_step() throws Throwable {
		System.out.println("Step definition with a non-capturing group");
	}
	
This step definition will match three different steps to one step definition. Note that I used logical operator described below.

	Scenario: Non-capturing group      # cucumber/regex.feature:9
	Given I have a tasty cucumber step # CucumberSteps.i_have_a_X_cucumber_step()
	Given I have a nasty cucumber step # CucumberSteps.i_have_a_X_cucumber_step()
	Given I have a rusty cucumber step # CucumberSteps.i_have_a_X_cucumber_step()
	
## Singular and plural

Use ? qualifier to match words in both singular and plural. ? at the end of a word makes the last letter optional. We can also use the logical alternative operator \| (pipe) to support correct grammar as well as irregular plurals which will make sentence read better.

	@Given("^There (?:is|are) (\\d+) (?:cats?|ox|oxen) fed by (\\d+) (?:persons?|people)$")
	public void animals_fed_by_people(int animals, int persons) throws Throwable {
		System.out.println(
				format("{0} animal(s) fed by {1} person(s)", animals, persons));
	}
	
	Given There is 1 cat fed by 1 person
	Given There are 2 cats fed by 1 person
	Given There are 2 cats fed by 2 persons
	Given There are 2 cats fed by 3 people
	Given There is 1 ox fed by 4 persons
	Given There are 3 oxen fed by 5 people

## Use Data Tables

You can use DataTable to manage larger amount of data. They are quite powerful but not the most intuitive as you either need to deal with a list of maps or a map of lists.

	@Given ("^I have the following order$")
	public void i_have_the_following_order (DataTable table) throws Throwable {
		for (Map<String, String> map : table.asMaps(String.class, String.class)) {
			String vegetable = map.get("vegetable");
			String amount = map.get("amount");
			String cost = map.get("cost");
			System.out.println(
					format("Order of {0} {1}s at the cost of {2}",
					amount, vegetable, cost));
		}
	}
	
	Scenario: Data tables
	  Given I have the following order
		| vegetable | amount | cost |
		| cucumber  |   4    |  10  |
		| carrot    |   5    |   6  |
		| potato    |   6    |   4  |
		
## Map data tables to domain objects

Luckily there are easier ways to access your data than [DataTable](http://cukes.info/api/cucumber/jvm/javadoc/cucumber/api/DataTable.html). For instance you can create a domain object and have Cucumber map your data in a table to a list of these.

	@Given("^I have another order$")
	public void i_have_another_order(List<OrderItem> list) throws Throwable {
		for (OrderItem orderItem : list) {
			String vegetable = orderItem.getVegetable ();
			int amount = orderItem.getAmount();
			int cost = orderItem.getCost ();
			System.out.println(
					format("Order of {0} {1}s at the cost of {2}",
					amount, vegetable, cost));
		}
	}
	
Our domain object – OrderItem

	package com.czeczotka.bdd.domain;
	 
	public class OrderItem {
	 
		private String vegetable;
		private int amount;
		private int cost;
	 
		public String getVegetable () {
			return vegetable;
		}
	 
		public void setVegetable (String vegetable) {
			this.vegetable = vegetable;
		}
	 
		public int getAmount () {
			return amount;
		}
	 
		public void setAmount (int amount) {
			this.amount = amount;
		}
	 
		public int getCost () {
			return cost;
		}
	 
		public void setCost (int cost) {
			this.cost = cost;
		}
	}
	
	Scenario: List of domain objects
	  Given I have another order
		| vegetable | amount | cost |
		| cucumber  |   4    |  10  |
		| carrot    |   5    |   6  |
		| potato    |   6    |   4  |
		
## More on Java and regular expressions

If you want a bit more detail on how regular expressions work in Java  probably the best  place to start is the [Java Tutorial](http://docs.oracle.com/javase/tutorial/essential/regex/) and the detailed javadoc for the [Pattern](http://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html) class.

## The code

The code of this post is on github so follow the link below to browse it.

http://github.com/czeczotka/cucumber-jvm-regex

You can easily clone and play with it locally by simply following these steps.

	$ git clone https://github.com/czeczotka/cucumber-jvm-regex.git
	$ cd cucumber-jvm-regex
	$ mvn test

I believe with the tools described here you have enough options to get started and create powerful step definitions. Last thing to note is that when you run the code above the System.out.println will appear before Cucumber output and this is because Cucumber displays its output after scenario execution when system outs have already written to the output stream.
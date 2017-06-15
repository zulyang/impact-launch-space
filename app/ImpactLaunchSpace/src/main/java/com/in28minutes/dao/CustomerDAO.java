package com.in28minutes.dao;

import com.in28minutes.entity.Customer;

public interface CustomerDAO
{
	public void insert(Customer customer);
	public Customer findByCustomerId(int custId);
}
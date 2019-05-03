﻿using System;
using System.Collections.Generic;
using System.Text;

namespace HardwareStore.Library
{
    /// <summary>
    /// A order object. Each order has a store location, a customer, an order time,
    /// and allows multiple types of products to be ordered at once. Gives customers 
    /// 5% discount if they spend 100 dollars or more.
    /// </summary>
    class Order
    {
        private int _customerId;
        private int _storeId;
        private DateTime _orderTime;
        public decimal _orderTotal;

        public int OrderId { get; set; }
        public int CustomerId { get; set; }
        public int StoreId { get; set; }

        public List<Products> _productsList;
        //TODO:maybe add customer and store name later?

        public DateTime OrderTime { get; set; }

        public List<Products> ProductsList
        {
            get { return _productsList; }
            set { _productsList = value; }
        }

        /// <summary>
        /// Total price for order. Cannot be less than 0.
        /// </summary>
        public decimal OrderTotal
        {
            get => _orderTotal;
            set
            {
                if (value < 0)
                {
                    throw new ArgumentException("Total can't be less than 0.", nameof(value));
                }
            }
        }

        /// <summary>
        /// Gives 5% discount if customer spends 100 or more
        /// </summary>
        public void Discount()
        {
            //TODO add code here
        }

    }
}

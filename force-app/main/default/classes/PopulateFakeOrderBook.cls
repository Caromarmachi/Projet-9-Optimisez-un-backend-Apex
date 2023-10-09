public with sharing class PopulateFakeOrderBook {
    private Account account1;

    public PopulateFakeOrderBook() {
    }

    public Account getAccount() {
        return this.account1;
    }

    public void createBasicOrder() {
        System.debug('Log CARO (PopulateFakeOrderBook) : creation de 1 order avec 1 produit');

        this.account1 = new Account(Name = 'Test Account 1');
        insert account1;
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;   
    //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 150,
            IsActive = true
        );
        insert pbe;
    // Créez l'Order en spécifiant le Pricebook
        Order o1 = new Order (
            AccountId = account1.Id, 
            EffectiveDate = Date.today(), 
            Status = 'Draft',
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert o1;
        OrderItem oi1 = new OrderItem (
            OrderId = o1.Id, 
            PricebookEntryId = pbe.Id, 
            Quantity=1, 
            UnitPrice = 150
            );
        insert oi1;


        System.debug('Log CARO (PopulateFakeOrderBook) : maj du statut de l order');
        o1.Status='Ordered';
        update o1;
    }



    public void create200Order() {
        System.debug('Log CARO (PopulateFakeOrderBook) : creation de 200 order avec 1 produit');

        this.account1 = new Account(Name = 'Test Account 1');
        insert account1;
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;   
    //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 150,
            IsActive = true
        );
        insert pbe;

        List<Order> maListeOrder = new List<Order>();
        List<OrderItem> maListeOrderItem = new List<OrderItem>();

        for (Integer i = 0; i < 200; i++) {
            Order o1 = new Order (
                AccountId = account1.Id, 
                EffectiveDate = Date.today(), 
                Status = 'Draft',
                Pricebook2Id = Test.getStandardPricebookId()
            );
            maListeOrder.add(o1);
        }
        insert(maListeOrder);

        for(Order order : maListeOrder) {
            OrderItem oi1 = new OrderItem (
                OrderId = order.Id, 
                PricebookEntryId = pbe.Id, 
                Quantity=1, 
                UnitPrice = 150
             );
             maListeOrderItem.add(oi1);
        }
         
     insert(maListeOrderItem);

     for(Order order : maListeOrder) {
        order.Status='Ordered';
     }
     
     update maListeOrder;


    }
}
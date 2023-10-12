trigger SumAmount on Order (before update) {
    System.debug('Log CARO (trigger SumAmount) : lancement trigger');

    List<Order> listeOrder = trigger.new;
    SumAmountService monService = new SumAmountService();
    monService.calculateNetAmount(listeOrder);
}


trigger UpdateAccountCA on Order (after update, after delete) {
    System.debug('Log CARO (trigger UpdateAccountCA) : lancement trigger');

    List<Order> listeOrder = trigger.new;
    UpdateAccountCAService monService = new UpdateAccountCAService();
    monService.updateAccountCA(listeOrder);
}
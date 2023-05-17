function payment() {
    // getter
    var IMP = window.IMP;
    IMP.init('imp99950854');
    var money = $('input[name="amount"]:checked').val();
    var methodList = ['kakaopay', 'payco', 'kicc'];
    var method = methodList[$('input[name="payment-method"]:checked').val()];
    IMP.request_pay({
        pg: method,
        pay_method: 'card',
        merchant_uid: 'merchant_' + new Date().getTime(),
        name: '주문명 : 캐시 충전',
        amount: money,
        buyer_email: 'iamport@siot.do',
        buyer_name: '구매자이름',
        buyer_tel: '010-1234-5678',
        buyer_addr: '서울특별시',
        buyer_postcode: '123-456'
    }, function (rsp) {
        console.log(rsp);
        if (rsp.success) {
            var msg = '결제가 완료되었습니다.';
            msg += '고유ID : ' + rsp.imp_uid;
            msg += '상점 거래ID : ' + rsp.merchant_uid;
            msg += '결제 금액 : ' + rsp.paid_amount;
            msg += '카드 승인번호 : ' + rsp.apply_num;
            $.ajax({
                type: "GET",
                url: "/payment/complete", //충전 금액값을 보낼 url 설정
                data: {
                    "amount" : money
                },
            });

        } else {
            var msg = '결제에 실패하였습니다. ';
            msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
        location.reload();
    });
}
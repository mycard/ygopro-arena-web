/**
  extensions is an Array and each item has such format:
  {firstName: 'xxx', lastName: 'xxx', ext: 'xxx', extType: 'xxx'}
  lastName, ext can be empty, extType can only has "DigitalUser", "VitrualUser","FaxUser","Dept","AO".
**/

/**
  Question 1: sort extensions by "firstName" + "lastName" + "ext" ASC
**/
function sortExtensionsByName(extensions) {
    if (!extensions) {
        return [];
    }
    extensions.sort(function (a, b) {
        var str1 = a.firstName + (a.lastName || '') + (a.ext || '')
        var str2 = b.firstName + (b.lastName || '') + (b.ext || '')
        return str1 > str2;
    })

    return extensions;
}

//test 
console.log('---- test of Question 1 start ----');
var extensions = [
    { firstName: 'a', ext: 'yyy2', extType: 'DigitalUser' },
    { firstName: 'a', ext: 'yyy1', extType: 'DigitalUser' },
    { firstName: 'c', lastName: 'bbb', ext: 'mmm', extType: 'VitrualUser' },
    { firstName: 'z', lastName: 'ccc', extType: 'FaxUser' },
    { firstName: 's', ext: 'xxx', extType: 'Dept' },
    { firstName: 'b', lastName: 'ddd', ext: 'mmm', extType: 'AO' }
];
console.log(sortExtensionsByName(extensions));

/**
  Question 2: sort extensions by extType follow these orders ASC
  DigitalUser < VitrualUser < FaxUser < AO < Dept.
**/
function sortExtensionsByExtType(extensions) {
    if (!extensions) {
        return [];
    }

    var extTypeOrder = ['DigitalUser', 'VitrualUser', 'FaxUser', 'AO', 'Dept']

    extensions.sort(function (a, b) {
        return extTypeOrder.indexOf(a.extType) - extTypeOrder.indexOf(b.extType);
    })

    return extensions;
}

//test 
console.log('---- test of Question 2 start ----');
var extensions = [
    { firstName: 'a', ext: 'yyy2', extType: 'AO' },
    { firstName: 'x', ext: 'yyy1', extType: 'Dept' },
    { firstName: 'c', ext: 'mmm', extType: 'VitrualUser' },
    { firstName: 'z', extType: 'FaxUser' },
    { firstName: 's', ext: 'xxx', extType: 'DigitalUser' },
    { firstName: 'b', ext: 'mmm', extType: 'AO' }
];
console.log(sortExtensionsByExtType(extensions));


/**
  saleItems is an Array has each item has such format:
  {
	month: n, //[1-12],
	date: n, //[1-31],
	transationId: "xxx",
	salePrice: number
  }
**/

/**
  Question 3: write a function to calculate and return a list of total sales (sum) for each quarter, expected result like:
  [
  	{quater: 1, totalPrices: xxx, transactionNums: n},
  	{....}
  ]
**/

function sumByQuater(saleItems) {
    var sumResult = [
        { quater: 1, totalPrices: 0, transactionNums: 0 },
        { quater: 2, totalPrices: 0, transactionNums: 0 },
        { quater: 3, totalPrices: 0, transactionNums: 0 },
        { quater: 4, totalPrices: 0, transactionNums: 0 },
    ]
    saleItems.forEach(function (saleItem) {
        var quaterIndex = Math.ceil(saleItem.month / 3) - 1;
        sumResult[quaterIndex].totalPrices += saleItem.salePrice;
        sumResult[quaterIndex].transactionNums++;
    })
    return sumResult;
}

//test
console.log('---- test of Question 3 start ----')
var saleItems = [
    { month: 1, date: 1, transationId: "a", salePrice: 11 },
    { month: 2, date: 2, transationId: "b", salePrice: 22 },
    { month: 3, date: 3, transationId: "a", salePrice: 33 },
    { month: 4, date: 4, transationId: "a", salePrice: 44 },
    { month: 5, date: 5, transationId: "a", salePrice: 55 },
    { month: 6, date: 6, transationId: "a", salePrice: 66 },
    { month: 7, date: 7, transationId: "a", salePrice: 11 },
    { month: 11, date: 8, transationId: "a", salePrice: 22 },
    { month: 12, date: 9, transationId: "a", salePrice: 33 },
];
console.log(sumByQuater(saleItems))

/**
  Question 4: write a function to calculate and return a list of average sales for each quarter, expected result like:
  [
    {quater: 1, averagePrices: xxx, transactionNums: n},
    {....}
  ]
**/

function averageByQuater(saleItems) {
    var sumByQuaterResult = sumByQuater(saleItems)
    sumByQuaterResult.forEach(function (quater) {
        quater.averagePrices = quater.totalPrices / quater.transactionNums;
        delete quater.totalPrices;
    })
    return sumByQuaterResult;
}


console.log('---- test of Question 4 start ----');
console.log(averageByQuater(saleItems));

/**
  Question 5: please create a tool to generate Sequence
  Expected to be used like:
  var sequence1 = new Sequence();
  sequence1.next() --> return 1;
  sequence1.next() --> return 2;
  
  in another module:
  var sequence2 = new Sequence();
  sequence2.next() --> 3;
  sequence2.next() --> 4;
**/

function Sequence() {

    if (typeof Sequence.instance === 'object') {
        return Sequence.instance;
    }

    this.count = 1;

    this.next = function () {
        return this.count++;
    }

    Sequence.instance = this;
}

// test
console.log('---- test of Question 5 start ----');
var sequence1 = new Sequence();
var sequence2 = new Sequence();
console.log(sequence1 === sequence2); // true
console.log(sequence1.next());
console.log(sequence1.next());
console.log(sequence2.next());
console.log(sequence2.next());


/**
    Question 6:
    AllKeys: 0-9;
    usedKeys: an array to store all used keys like [2,3,4];
    We want to get an array which contains all the unused keys,in this example it would be: [0,1,5,6,7,8,9]
**/

function getUnUsedKeys(allKeys, usedKeys) {
    var unUsedKey = allKeys.filter(function (a) {
        return usedKeys.indexOf(a) === -1;
    })

    return unUsedKey;
}

//test 
console.log('---- test of Question 6 start ----');
var usedKeys = [2, 3, 4];
var allKeys = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
console.log(getUnUsedKeys(allKeys, usedKeys));




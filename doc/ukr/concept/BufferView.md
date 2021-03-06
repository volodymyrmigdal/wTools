# Тип <code>BufferView</code>

Cтандартний нетипізований буфери для динамічного типізування даних `BufferRaw`.

[Тип `BufferView`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DataView) має всього одну реалізацію `BufferView` ( `DataView` ). Буфери типу `BufferView` так само які і `BufferTyped` не володіють даними, а є представленнями даних, які знаходяться в асоційованому із цим буфером `BufferRaw`. На відміну від `BufferTyped` тип `BufferView` не типізує елементи статично, а надає методи для динамчіної типізації змісту в будь-який числовий примітив.

Для створення екземпляру буфера `BufferView` в конструктор класу передається буфер типу `BufferRaw`, зміщення на кількість байтів від початку і кількість байтів для читання. Якщо передати буфер не вказавши зміщення і розміру то буде створено новий `BufferView` з всього вмісту. При створенні екземпляра `BufferView`, фактично передається посилання на відповідну ділянку буфера типу `BufferRaw`, а не створюється її копія. Цим `BufferView` подібний до `BufferTyped`. Тому, при зміні початкового буфера `BufferRaw` в одному з представлень, змінюється представлення у всіх екземплярах класу `BufferView`, котрі використовують даний `BufferRaw`.

### Приклади

```js
var raw = new BufferRaw( 20 );

var view1 = new BufferView( raw );
var view2 = new BufferView( raw, 10, 9 );

console.log( view1.getInt8( 17 ), view2.getInt8( 7 ) ); // log 0 0
console.log( view1.getUint16( 17 ), view2.getUint16( 7 ) ); // log 0 0

view1.setInt8( 17, -42 );
console.log( view1.getInt8( 17 ), view2.getInt8( 7 ) ); // log -42 -42
console.log( view1.getUint16( 17 ), view2.getUint16( 7 ) ); // log 54784 54784

view2.setUint16( 6, 100 );
console.log( view1.getInt8( 16 ), view2.getInt8( 6 ) ); // log 0 0
console.log( view1.getUint16( 16 ), view2.getUint16( 6 ) ); // log 100 100
```

<!-- Kos : оновити значення які виводяться із log -->

В приведеному прикладі з буферу `raw` створено два представлення типу `BufferView` - `view1` i `view2`. Представлення `view1` використовує весь буфер `raw`. Одночасно, представлення `view2` використовує дев'ять байтів буферу `raw` починаючи з десятого байта від початку. Буфер `raw` виділив ініціалізовану ділянку пам'яті, тому спочатку в обох представленнях кожен байт має значення `0`.

<!-- Kos : змінити опис починаючи з цього моменту щоб він відповідав оновленому прикладу -->

За допомогою методу `setInt8` представлення `view1` змінює значення байта 17 в буфері `raw` на число `-42`. Ця зміна відображена і в буфері `view2`. Використання методу `getUint16` показує, що одну і ту ж ділянку бінарних даних можна інтерпретувати по-різному. При зчитуванні двох байтів починаючи з 17-го, представлення `view1` повертає число `54784`. Значення буферу `view1` ідентичне, бо зчитується одна і та ж ділянка буфера `raw`.

Представлення `view2` за допомогою методу `setUint16` змінило два байти починаючи з 6 на значення `100`. Після проведених змін при зчитуванні одного байта з індексом 6 повернене значення - `0`. Це пояснюється тим, що для запису числа `100` достатньо одного молодшого байта двохбайтного числа. При зчитуванні 2 байтів починаючи з 6, метод `getUint16` повернув записане число `100`. Відповідні зміни відображені в представленні `view1`.

### Підсумок

- Екземпляри типу `BufferView` є представленнями буферів типу `BufferRaw`.
- При створенні екземпляру `BufferView`, фактично передається посилання на ділянку буфера `BufferRaw` без його копіювання.
- `BufferView` не володіє даними.
- Доступ до даних в `BufferView` здійснюється за допомогою методів.
- Зміни в оригінальному буфері `BufferRaw` ведуть до змін у всіх пов'язаних із ним представленнях.

[Повернутись до змісту](../README.md#Концепції)

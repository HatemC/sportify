import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";


const initFlatpickr = () => {
  flatpickr(".datepickr", {
    altInput: true,
    plugins: [new rangePlugin({ input: "#range_end" })]
  });
}


const initFlatpickr2 = () => {
  flatpickr(".datepicker", {
  });
}


export { initFlatpickr };
export { initFlatpickr2};

use yew::prelude::*;
use web_sys::{
    wasm_bindgen::JsCast, HtmlInputElement 
};


#[function_component]
fn App() -> Html {
    let counter = use_state(|| 0);
    let coopname = use_state(|| String::new());

    let onclick = {
        let counter = counter.clone();
        move |_| {
            let value = *counter + 1;
            counter.set(value);
        }
    };

    let onkeyup = {
        let coopname = coopname.clone();
        move |e: KeyboardEvent| {
            match e.target() {
                Some(event_target) => {
                    let val = event_target.dyn_ref::<HtmlInputElement>().unwrap().value();
                    coopname.set(val);
                },
                None => {}
            } 
        }
    };

    html! {
        <div>
            <form action="" >
                <input type="text" id="coopname" name="coopname" placeholder="Nombre de la coope" {onkeyup}/>
                <input type="text" id="matricula" name="matricula" placeholder="Matricula"/>
                <button {onclick} disabled={coopname.is_empty()}>{ "Comenzar" }</button>
            </form>
        </div>
    }
}


fn main() {
    wasm_logger::init(wasm_logger::Config::default());
    yew::Renderer::<App>::new().render();
}
